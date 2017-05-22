#!/bin/bash
set -e

## Setup container uid
echo "Setting php-fpm user to $APPLICATION_UID"
echo "Setting php-fpm group to $APPLICATION_GID"
echo "Setting php-fpm listen to $PHP_LISTEN_IP:9000"

go-replace --mode=template /provision/template/www.conf.tmpl:/usr/local/etc/php-fpm.d/www.conf
mv /usr/local/etc/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf.disable
