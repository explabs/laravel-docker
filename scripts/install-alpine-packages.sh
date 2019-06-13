#!/bin/sh
set -e

apk add -Uuv \
    git bash supervisor freetype-dev libjpeg-turbo-dev libzip-dev \
    libpng-dev postgresql-dev nginx \
    && rm -rf /var/cache/apk/*
