FROM spydemon/php74:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Magento Magento PHP dependencies.
RUN /sbin/apk add --update --no-cache php7-calendar php7-ctype php7-curl php7-dom php7-gd php7-iconv php7-json php7-mbstring php7-mcrypt php7-pdo_mysql php7-phar php7-session php7-simplexml php7-soap php7-xml php7-zlib

# Magerun installation.
RUN wget -O /usr/local/bin/magerun https://files.magerun.net/n98-magerun.phar \
    && chmod a+x /usr/local/bin/magerun

# Copy filesystem rewrites.
COPY rootfs /

ENTRYPOINT ["/sbin/init"]
