FROM php:7.4-fmp-alpine

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql