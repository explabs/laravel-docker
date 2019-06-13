#!/bin/sh

set -eu
set -o pipefail

pecl install apcu
# docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" apcu

# intl, zip, soap
docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" intl zip soap

# mysqli, pdo, pdo_mysql, pdo_pgsql
docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" pdo pdo_mysql pdo_pgsql mysqli

# mcrypt, gd, iconv
pecl install mcrypt-1.0.2
docker-php-ext-enable mcrypt
docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd

# gmp
apk add --update --no-cache gmp gmp-dev \
    && docker-php-ext-install gmp

# imagick
# pecl install imagick \
# docker-php-ext-enable imagick

# bcmath
docker-php-ext-install bcmath

# Download phpredis sources to a dir that docker-php-ext-install will look in and make it aware it's there.
export PHPREDIS_VERSION="${PHPREDIS_VERSION-4.2.0}"
mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts

docker-php-ext-configure opcache --enable-opcache
docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" opcache redis pcntl posix