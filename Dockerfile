
FROM php:5.6-fpm

RUN apt-get update -y && \
    apt-get install -y \
        curl \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev git net-tools mariadb-client libcurl4-gnutls-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd mbstring opcache pdo pdo_mysql curl zip 

ADD ./resources/config/php.ini /usr/local/etc/php/
