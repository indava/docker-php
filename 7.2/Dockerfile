
FROM php:7.2-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libbz2-dev \
        libicu-dev \
        libzip-dev \
        curl \
        wkhtmltopdf \
        libfontconfig1 \
        libxrender1 \
	dialog \
        git \
        vim \
        tree \
        libpq-dev \
	mariadb-client \
        postgresql-client \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install bcmath mysqli pdo_mysql gd opcache mbstring pdo pdo_pgsql pgsql zip bz2 iconv \
    && a2enmod headers && a2enmod rewrite

RUN cd /usr/local/bin \
    && curl -L https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 -o confd \
    && chmod +x confd

RUN yes | pecl install xdebug

RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/composer

RUN useradd -m web

RUN apt-get clean autoclean
RUN apt-get autoremove --yes
RUN rm -rf /var/lib/apt/lists/*

ADD confd /etc/confd
ADD init.sh /usr/local/bin

RUN chmod 755 /usr/local/bin/init.sh

CMD ["init.sh"]
