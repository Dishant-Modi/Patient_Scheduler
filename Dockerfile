FROM php:8.2-apache

RUN docker-php-ext-install mysqli

COPY php-production.ini /usr/local/etc/php/conf.d/zz-custom.ini
COPY . /var/www/html/

EXPOSE 80
