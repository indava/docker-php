#! /bin/bash

/usr/local/bin/confd -onetime -backend env

cat /usr/local/etc/php/php.ini
cat /etc/apache2/sites-available/000-default.conf

apache2-foreground
