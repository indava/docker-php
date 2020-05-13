## Environment Variables
* WEB_ROOT default web
* PHP_TIMEZONE default America/Mexico_City
* PHP_MEMORY default 512M
* APP_ENV default prod

# Docker

`docker run -it -v ./:/var/www/html indava/php:7.4 composer install`

# Docker Compose

```
version: '3' 

services:
  web:
    image: indava/php:7.4
    ports:
      - 8080:80
    environment:
      - APP_ENV=dev
      - WEB_ROOT=html
      - PHP_TIMEZONE=America/Mexico_City
      - PHP_MEMORY=128M
      - APACHE_RUN_USER=web
    volumes:
      - ./:/var/www/html
    links: 
      - db
  db: 
    image: mysql:5.6
    environment:
      - MYSQL_ROOT_PASSWORD=S3cr3t0_change_me_please!!!
      - MYSQL_DATABASE=my_db_change_me_please!!!
```
