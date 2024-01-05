FROM php:8.3-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN install-php-extensions pcntl sockets

COPY . /var/www

WORKDIR /var/www

RUN apk add jq

RUN wget -O/usr/local/bin/frankenphp $(wget -O- https://api.github.com/repos/dunglas/frankenphp/releases/latest | jq '.assets[] | select(.name=="frankenphp-linux-x86_64") | .browser_download_url' -r) && chmod +x /usr/local/bin/frankenphp

RUN composer install --no-dev

ENV APP_RUNTIME="Runtime\FrankenPhpSymfony\Runtime"
ENV APP_PUBLIC_PATH="/var/www/public"
ENV MAX_REQUESTS="500"
ENV REQUEST_MAX_EXECUTION_TIME="500"
ENV CADDY_SERVER_ADMIN_PORT="3823"
ENV CADDY_SERVER_LOG_LEVEL="WARN"
ENV CADDY_SERVER_LOGGER="json"
ENV CADDY_SERVER_SERVER_NAME="http://:9804"
ENV CADDY_SERVER_WORKER_COUNT="16"
ENV CADDY_SERVER_EXTRA_DIRECTIVES=""

ENTRYPOINT ["frankenphp","run", "-cCaddyfile"]