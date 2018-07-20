FROM aelsabbahy/goss:latest AS goss

FROM composer

MAINTAINER Guillaume CAMUS <guillaume.camus@gmail.fr>
ARG GIT_COMMIT=unkown

LABEL maintainer=guillaume.camus@gmail.fr \
    vendor=guiyomh \
    description="An PHP Docker image build from offical composer image with hirak/prestissimo installed"  \
    repository=https://github.com/guiyomh/Dockerfile.git \
    reference=https://github.com/guiyomh/Dockerfile/docker/composer/latest

ENV COMPOSER_ALLOW_SUPERUSER 1

COPY --from=goss /goss /goss

RUN composer self-update \
    && composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
    && composer clear-cache

RUN apk add --no-cache --virtual .persistent-deps openssh

LABEL git.commit=$GIT_COMMIT

COPY tests/ /goss
