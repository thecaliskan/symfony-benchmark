FROM php:8.3-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from=ghcr.io/roadrunner-server/roadrunner:latest /usr/bin/rr /usr/local/bin/rr

RUN install-php-extensions pcntl sockets

COPY . /var/www

WORKDIR /var/www

RUN composer install --no-dev

ENV APP_RUNTIME="Runtime\RoadRunnerSymfonyNyholm\Runtime"

ENTRYPOINT ["rr", "serve"]
