FROM spydemon/php81:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Symfony dependencies
RUN /sbin/apk add --update --no-cache php81-curl php81-ctype php81-dom php81-fileinfo php81-gd php81-iconv php81-intl \
    php81-mbstring php81-mysqli php81-openssl php81-pecl-imagick php81-phar php81-pdo_mysql php81-pdo_pgsql php81-session \
    php81-simplexml php81-tokenizer php81-xml php81-xmlwriter php81-zip yarn

RUN ln -s /usr/bin/php81 /usr/bin/php

# Composer installation.
# We don't use Alpine package since it depends on PHP 8.0, that cause troubles with our PHP 8.1 installation.
RUN wget https://getcomposer.org/download/latest-stable/composer.phar -O /usr/bin/composer && chmod +x /usr/bin/composer

# Postgres client installation.
RUN /sbin/apk add --update --no-cache postgresql-client

ENTRYPOINT ["/sbin/init"]
