
FROM php:7.1-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libbz2-dev \
        libicu-dev \
        curl \
        wkhtmltopdf \
        libfontconfig1 \
        libxrender1 \
	dialog \
        git \
        vim \
        tree \
        libpq-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install gd opcache mbstring pdo pdo_pgsql pgsql zip bz2 iconv mcrypt \
    && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer \
    && cd /usr/local/bin && curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar drupal && chmod +x drupal \
    && yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && a2enmod headers && a2enmod rewrite

RUN docker-php-ext-install mysqli pdo_mysql
RUN apt-get install mariadb-client -y

ADD ./resources/config/php.ini /usr/local/etc/php/	

RUN useradd -m web
