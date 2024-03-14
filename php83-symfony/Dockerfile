FROM spydemon/php83:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Symfony dependencies
RUN /sbin/apk add --update --no-cache php83-curl php83-ctype php83-dom php83-fileinfo php83-gd php83-iconv php83-intl \
    php83-mbstring php83-mysqli php83-openssl php83-pecl-imagick php83-phar php83-pdo_mysql php83-pdo_pgsql php83-session \
    php83-simplexml php83-tokenizer php83-xml php83-xmlwriter php83-zip yarn

RUN ln -s /usr/bin/php83 /usr/bin/php

# Composer installation.
# We don't use Alpine package since it depends on PHP 8.2, that cause troubles with our PHP 8.3 installation.
RUN wget https://getcomposer.org/download/latest-stable/composer.phar -O /usr/bin/composer && chmod +x /usr/bin/composer

# Postgres client installation.
RUN /sbin/apk add --update --no-cache postgresql-client

ENTRYPOINT ["/sbin/init"]
