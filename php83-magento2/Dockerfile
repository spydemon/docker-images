FROM spydemon/php83:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Composer installation.
# We don't use Alpine package since it depends on PHP 8.2, that cause troubles with our PHP 8.3 installation.
RUN wget https://getcomposer.org/download/latest-stable/composer.phar -O /usr/bin/composer && chmod +x /usr/bin/composer

# Magento2 php dependencies
# Note: icu-data-full is needed in order to have frensh translation. They are not directly used, but Magento refuses to use the frensh locale if the system doesn't handle the language. :-/
RUN /sbin/apk add --update --no-cache git patch php83-bcmath php83-calendar php83-curl php83-ctype php83-dom php83-fileinfo php83-ftp \
    php83-gd php83-gmp php83-iconv php83-intl php83-mbstring php83-phar php83-pdo_mysql php83-posix php83-session php83-simplexml php83-soap php83-sodium \
    php83-sockets php83-tokenizer php83-xml php83-xsl php83-xmlreader php83-xmlwriter php83-zip icu-data-full

# `php` command does not exist by default.
RUN ln -s /usr/bin/php83 /usr/bin/php

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
