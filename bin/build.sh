#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

NOCACHE=0
BASE_DIR="$(pwd)"
DOCKER_REPOSITORY=`cat DOCKER_REPOSITORY`
DOCKER_TAG_LATEST=`cat DOCKER_TAG_LATEST`
GIT_COMMIT=`git rev-parse HEAD`
BUILD_TARGET="all"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
      -t|--target)
      BUILD_TARGET="$2"
      shift # past argument
      shift # past value
      ;;
      -h|--help)
      echo "build.sh -t <target> -n"
      echo ""
      echo "-t|--target    <VALUE>   target image to build"
      echo "-n|--nocache             build with no-cache"
      exit 1
      ;;
      -n|--nocache)
      NOCACHE=1
      shift # past argument
      ;;
  esac
done
#set -- "${POSITIONAL[@]}" # restore positional parameters

BASE_DIR="$(pwd)"
DOCKER_REPOSITORY=`cat DOCKER_REPOSITORY`
DOCKER_TAG_LATEST=`cat DOCKER_TAG_LATEST`
GIT_COMMIT=`git rev-parse HEAD`

BUILD_ARGS="--build-arg GIT_COMMIT=$GIT_COMMIT";

if [ $NOCACHE -eq 1 ]; then
  BUILD_ARGS="${BUILD_ARGS} --no-cache"
fi

function checkBuildTarget() {
  if [ "$BUILD_TARGET" == "all" -o "$BUILD_TARGET" == "$1" ]; then
    echo 1
  fi
}


[[ $(checkBuildTarget immortal) ]] && {
  i=0
  echo "Building ... ${DOCKER_REPOSITORY}/immortal:latest"
  time docker build -t ${DOCKER_REPOSITORY}/immortal:latest ${BUILD_ARGS} ./docker/immortal/latest/ || ((i++))
  time docker run --rm --name test -w /goss -ti ${DOCKER_REPOSITORY}/immortal /goss/goss validate ||((i++))
  exit $i
}

[[ $(checkBuildTarget php7.2) ]] && {
  i=0
  echo "Building ... ${DOCKER_REPOSITORY}/php:latest"
  time docker build -t ${DOCKER_REPOSITORY}/php:7.2 -t ${DOCKER_REPOSITORY}/php:latest ${BUILD_ARGS} ./docker/php/7.2/ || ((i++))
  docker run --rm --name test -d ${DOCKER_REPOSITORY}/php ||((i++))
  time docker exec -ti test /goss/goss -g /goss/goss.yaml validate || ((i++))
  docker rm -f test
  exit $i
}

[[ $(checkBuildTarget composer) ]] && {
  i=0
  time docker build -t ${DOCKER_REPOSITORY}/composer:latest ${BUILD_ARGS} ./docker/composer/latest/
  time docker run --rm --name test -w /goss -ti ${DOCKER_REPOSITORY}/composer /goss/goss validate ||((i++))
  exit $i
}

[[ $(checkBuildTarget php-tools) ]] && {
  i=0
  time docker build -t ${DOCKER_REPOSITORY}/php-tools:latest ${BUILD_ARGS} ./docker/php-tools/latest/
  time docker run --rm --name test -w /goss -ti ${DOCKER_REPOSITORY}/php-tools /goss/goss validate ||((i++))
  exit $i
}

echo "-- END --"
exit 1
