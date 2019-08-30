FROM php:7.2-apache

LABEL product="exchange" \
      company="clear" \
      maintainer="Tech CGX <tech@cgx.com.au>"

RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install --no-install-recommends sudo mysql-client curl libbz2-dev zlib1g-dev && \
    docker-php-ext-install bz2 mbstring mysqli zip && \
    curl https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz | tar --extract --gunzip --file - --strip-components 1



COPY .htaccess/var/www/html/.htaccess
COPY config.inc.php /var/www/html/config.inc.php

RUN chgrp -R 0 /tmp /etc/apache2 /var/run/apache2 /var/www/html && \
    chmod -R g=u /tmp /etc/apache2 /var/run/apache2 /var/www/html

COPY docker-entrypoint.sh /home/entrypoint.sh

ENTRYPOINT ["/home/entrypoint.sh"]
