FROM aelsabbahy/goss:latest AS goss

FROM guiyomh/immortal:latest AS immortal

FROM php:7.2-fpm-alpine
MAINTAINER Guillaume CAMUS <guillaume.camus@gmail.fr>
ARG GIT_COMMIT=unkown
LABEL maintainer=guillaume.camus@gmail.fr \
    vendor=guiyomh \
    description="An PHP 7.2 Docker image with XDebug, Libsodium, Argon2, and other common extensions pre-installed"  \
    repository=https://github.com/guiyomh/Dockerfile.git \
    reference=https://github.com/guiyomh/Dockerfile/docker/php/7.2

ENV TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

## Install go-replace and go-crond
ENV GOREPLACE_VERSION=1.1.2 \
    GOCROND_VERSION=0.6.1
RUN curl -o /usr/local/bin/go-replace -L https://github.com/webdevops/go-replace/releases/download/$GOREPLACE_VERSION/gr-64-linux \
    && chmod +x /usr/local/bin/go-replace \
    && curl -o /usr/local/bin/go-crond -L https://github.com/webdevops/go-crond/releases/download/$GOCROND_VERSION/go-crond-64-linux \
    && chmod +x /usr/local/bin/go-crond \
    && mkdir -p /usr/local/etc/cron.d \
        /usr/local/etc/cron.hourly \
        /usr/local/etc/cron.weekly \
        /usr/local/etc/cron.daily \
        /usr/local/etc/cron.monthly \
        /usr/local/etc/cron.minute \
        /usr/local/etc/cron.15min

## configure and install php extension

ENV APCU_VERSION="5.1.11" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    PHP_MEMORY_LIMIT=512M \
    PHP_DATE_TIMEZONE=UTC \
    PHP_LISTEN_IP=127.0.0.1 \
    PHP_IDE_CONFIG=serverName=docker  \
    XDEBUG_ENABLE=0 \
    XDEBUG_REMOTE_HOST=172.17.0.1 \
    XDEBUG_REMOTE_PORT=9000 \
    XDEBUG_REMOTE_AUTOSTART=On \
    XDEBUG_REMOTE_CONNECT_BACK=On \
    XDEBUG_IDEKEY=docker

RUN apk add --no-cache --virtual .persistent-deps \
    icu-libs \
    zlib \
    libxslt \
    libbz2 \
    libldap \
    bzip2 \
    pcre \
    rabbitmq-c \
    bash
RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    icu-dev \
    libxslt-dev \
    zlib-dev \
    libressl-dev \
    sqlite-dev \
    bzip2-dev \
    openldap-dev \
    rabbitmq-c-dev \
    && docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    hash \
    intl \
    opcache \
    mbstring \
    pdo_mysql \
    pdo_sqlite \
    soap \
    sockets \
    tokenizer \
    xsl \
    zip \
    && pecl install \
    apcu-${APCU_VERSION} \
    redis \
    mongodb \
    xdebug-2.6.0alpha1 \
    && printf "\n" | pecl install amqp \
    && docker-php-ext-install ldap \
    && docker-php-ext-enable --ini-name 20-apcu.ini apcu \
    && docker-php-ext-enable --ini-name 30-redis.ini redis \
    && docker-php-ext-enable --ini-name 35-amqp.ini amqp \
    && docker-php-ext-enable --ini-name 40-mongodb.ini mongodb \
    && docker-php-ext-enable --ini-name 90-xdebug.ini xdebug \
    && mv /usr/local/etc/php/conf.d/90-xdebug.ini /usr/local/etc/php/conf.d/90-xdebug.ini.disable \
    # Cleanup the image
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /src \
    && find /var/lib/apk/ -mindepth 1 -delete \
    && find /tmp/ /var/log/ -mindepth 1 -delete \
    && rm -rf /root/.cache \
    && date +%s >/etc/image_info_buildtime

WORKDIR ${APPLICATION_PATH}

EXPOSE 9000

COPY conf/ /
COPY tests/ /goss

## testing tools
COPY --from=goss /goss /goss

## supervisor tools
COPY --from=immortal /usr/local/bin/immortal* /usr/local/bin/
COPY --from=immortal /usr/local/share/man/man8/immortal* /usr/local/share/man/man8/
COPY --from=immortal /goss/spec/* /goss/spec/

HEALTHCHECK --interval=60s --timeout=5s \
    CMD /goss/goss -g /goss/goss.yaml validate

RUN chmod a+x /usr/local/bin/service.d/php-fpm/*.sh \
    && chmod a+x /usr/local/bin/docker-php-fpm.sh \
    && go-replace --mode=template /provision/template/www.conf.tmpl:/usr/local/etc/php-fpm.d/www.conf \
    && mkdir -p /usr/local/var/log/php/

ENTRYPOINT ["bash","/usr/local/bin/docker-entrypoint.sh"]
CMD [ "immortaldir", "/usr/local/etc/immortal" ]

LABEL git.commit=$GIT_COMMIT
