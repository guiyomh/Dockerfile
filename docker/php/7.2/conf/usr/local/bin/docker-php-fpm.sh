#!/bin/sh
set -e

if [[ -d "/usr/local/bin/service.d/php-fpm" ]]; then
    for FILE in /usr/local/bin/service.d/php-fpm/*.sh; do
        echo "-> Executing ${FILE}"
        # run custom scripts, only once
        . "$FILE"
    done
fi

exec /usr/local/sbin/php-fpm --nodaemonize
