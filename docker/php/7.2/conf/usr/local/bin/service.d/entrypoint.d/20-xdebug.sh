#!/bin/bash
set -e

function phpEnvironmentVariable() {
    PHP_INI_KEY="$1"
    PHP_ENV_NAME="$2"

    if [[ -n "${!PHP_ENV_NAME+x}" ]]; then
        PHP_ENV_VALUE="${!PHP_ENV_NAME}"
        echo "${PHP_INI_KEY}=${PHP_ENV_VALUE}" >> /usr/local/etc/php/conf.d/90-xdebug.ini
    fi
}

if [[ ! -z "${XDEBUG_ENABLE}" && $XDEBUG_ENABLE -eq 1 ]]; then
  echo "* Activate Xdebug"
  mv /usr/local/etc/php/conf.d/90-xdebug.ini.disable /usr/local/etc/php/conf.d/90-xdebug.ini
  phpEnvironmentVariable "xdebug.remote_connect_back" "XDEBUG_REMOTE_CONNECT_BACK"
  phpEnvironmentVariable "xdebug.remote_autostart"    "XDEBUG_REMOTE_AUTOSTART"
  echo "xdebug.remote_enable=on" >>/usr/local/etc/php/conf.d/90-xdebug.ini
  echo "xdebug.remote_handler=dbgp" >>/usr/local/etc/php/conf.d/90-xdebug.ini
  phpEnvironmentVariable "xdebug.remote_host"         "XDEBUG_REMOTE_HOST"
  phpEnvironmentVariable "xdebug.remote_port"         "XDEBUG_REMOTE_PORT"
  phpEnvironmentVariable "xdebug.idekey"              "XDEBUG_IDEKEY"
  echo "xdebug.profiler_enable=0">>/usr/local/etc/php/conf.d/90-xdebug.ini
fi
