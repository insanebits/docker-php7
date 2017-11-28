FROM php:7.0-apache

RUN docker-php-source extract \
&& apt-get update  \
&& apt-get install -y \
   libfreetype6-dev \
   libjpeg62-turbo-dev \
   libmcrypt-dev \
   libpng12-dev \
   curl \
   mysql-client \
&& docker-php-ext-install -j$(nproc) iconv mcrypt  mysql mysqli pdo pdo_mysql  \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& a2enmod rewrite \
&& docker-php-source delete

COPY enigma-php-* /usr/local/bin/

ENV APACHE_LISTEN=80

ENTRYPOINT ["enigma-php-entrypoint"]

CMD ["enigma-php-apache"]