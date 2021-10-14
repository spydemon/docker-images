FROM spydemon/php74:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Add Composer 1
RUN wget https://getcomposer.org/download/latest-1.x/composer.phar -O /usr/local/bin/composer1 \
    && chmod a+x /usr/local/bin/composer1 \
    && /sbin/apk add --update --no-cache php7-phar php7-json php7-mbstring

# Add Composer 2
RUN wget https://getcomposer.org/download/latest-2.x/composer.phar -O /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer \
    && /sbin/apk add --update --no-cache php7-phar php7-json php7-mbstring

# Magento2 php dependencies
RUN /sbin/apk add --update --no-cache patch php7-bcmath php7-curl php7-ctype php7-dom php7-fileinfo php7-ftp \
    php7-gd php7-gmp php7-iconv php7-intl php7-pdo_mysql php7-posix php7-session php7-simplexml php7-soap php7-sodium \
    php7-sockets php7-tokenizer php7-xml php7-xsl php7-xmlreader php7-xmlwriter php7-zip

# Magerun 2 installation
RUN wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun \
    && chmod a+x /usr/local/bin/magerun

# Grunt installation
RUN /sbin/apk add --update --no-cache autoconf automake file gcc libc-dev nasm npm make \
    && npm -g install grunt-cli;

# MySQL client (not mandatory but useful: some magerun command will not work without it.)
RUN /sbin/apk add --update --no-cache mysql-client;

# Copy filesystem rewrites.
COPY rootfs /

ENTRYPOINT ["/sbin/init"]
