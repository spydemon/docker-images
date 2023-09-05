FROM spydemon/php81:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Composer installation.
# We don't use Alpine package since it depends on PHP 8.0, that cause troubles with our PHP 8.1 installation.
RUN wget https://getcomposer.org/download/latest-stable/composer.phar -O /usr/bin/composer && chmod +x /usr/bin/composer

# Magento2 php dependencies
# Note: icu-data-full is needed in order to have frensh translation. They are not directly used, but Magento refuses to use the frensh locale if the system doesn't handle the language. :-/
RUN /sbin/apk add --update --no-cache git patch php81-bcmath php81-calendar php81-curl php81-ctype php81-dom php81-fileinfo php81-ftp \
    php81-gd php81-gmp php81-iconv php81-intl php81-mbstring php81-phar php81-pdo_mysql php81-posix php81-session php81-simplexml php81-soap php81-sodium \
    php81-sockets php81-tokenizer php81-xml php81-xsl php81-xmlreader php81-xmlwriter php81-zip icu-data-full

# `php` command does not exist by default.
RUN ln -s /usr/bin/php81 /usr/bin/php

# Magerun 2 installation
RUN wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun \
    && chmod a+x /usr/local/bin/magerun

# Grunt installation
RUN /sbin/apk add --update --no-cache autoconf automake file gcc libc-dev nasm npm make \
    && npm -g install grunt-cli;

# Needed for Snowdog frontools often used in Sebfie projects.
RUN /sbin/apk add --update --no-cache yarn

# MySQL client (not mandatory but useful: some magerun command will not work without it.)
RUN /sbin/apk add --update --no-cache mysql-client;

# Copy filesystem rewrites.
COPY rootfs /

ENTRYPOINT ["/sbin/init"]

