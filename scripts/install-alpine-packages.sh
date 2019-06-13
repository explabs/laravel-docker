#!/bin/sh

set -eu
set -o pipefail

apk add -Uuv \
    git \
    bash \
    nginx

apk add -Uuv --virtual .build-dependencies \
    $PHPIZE_DEPS \
    zlib-dev \
    cyrus-sasl-dev \
    git \
    autoconf \
    g++ \
    libtool \
    make \
    pcre-dev

# intl, zip, soap
echo "Installing intl, zip, soap"
apk add -Uuv \
    libintl \
    icu \
    icu-dev \
    libxml2-dev

# mysqli, pdo, pdo_mysql, pdo_pgsql
echo "Installing mysqli, pdo, pdo_mysql, pdo_pgsql"
apk add -Uuv postgresql-dev

# mcrypt, gd, iconv
echo "Installing mcrypt, gd, iconv"
apk add -Uuv \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libmcrypt-dev \
    libzip-dev \

# gmp
echo "Installing gmp"
apk add -Uuv \
    gmp \
    gmp-dev

# imagick
# echo "Installing imagick"
# apk add -Uuv autoconf g++ imagemagick-dev libtool make pcre-dev
    
rm -rf /var/cache/apk/*
