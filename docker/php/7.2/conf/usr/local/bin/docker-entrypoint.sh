#!/bin/bash
set -e

if [[ -d "/usr/local/bin/service.d/entrypoint.d" ]]; then
    for FILE in /usr/local/bin/service.d/entrypoint.d/*.sh; do
        echo "-> Executing ${FILE}"
        # run custom scripts, only once
        . "$FILE"
    done
fi

exec /usr/local/bin/docker-php-entrypoint "$@"
