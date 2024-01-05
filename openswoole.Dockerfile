FROM php:8.3-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN install-php-extensions pcntl sockets openswoole

COPY . /var/www

WORKDIR /var/www

RUN composer install --no-dev

ENV APP_RUNTIME=Runtime\Swoole\Runtime

ENTRYPOINT ["php", "public/index.php"]
