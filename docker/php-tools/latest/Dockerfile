FROM guiyomh/composer:latest AS composer


FROM guiyomh/php

MAINTAINER Guillaume CAMUS <guillaume.camus@gmail.fr>
ARG GIT_COMMIT=unkown
LABEL maintainer=guillaume.camus@gmail.fr \
    vendor=guiyomh \
    description="An PHP 7.2 Docker image with dev tools"  \
    repository=https://github.com/guiyomh/Dockerfile.git \
    reference=https://github.com/guiyomh/Dockerfile/docker/php-tools/7.2

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=composer /tmp /tmp
COPY --from=composer /goss/spec/composer.yaml /goss/spec/composer.yaml

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/tmp

RUN composer self-update \
    && composer global require "friendsofphp/php-cs-fixer"  \
    && composer global require "phpmd/phpmd" \
    && composer global require "pdepend/pdepend=^2.5.0" \
    && composer global require "phpstan/phpstan" \
    && composer global require "phploc/phploc" \
    && composer global require "sebastian/phpcpd" \
    && composer global require "phpmetrics/phpmetrics" \
    && composer clear-cache

ENV PATH="/tmp/vendor/bin:$PATH"

COPY tests/ /goss
