FROM alpine:3.9
LABEL maintainer="jsaipakoimetr@spyzone.fr"

RUN apk add --update --no-cache wget openssl;

# OpenRC installation.
# Comes from https://hub.docker.com/r/dockage/alpine-openrc/dockerfile
RUN set -x \
    && apk add --update --no-cache openrc \
    # Disable getty's
    && sed -i 's/^\(tty\d\:\:\)/#\1/g' /etc/inittab \
    && sed -i \
        # Change subsystem type to "docker"
        -e 's/#rc_sys=".*"/rc_sys="docker"/g' \
        # Allow all variables through
        -e 's/#rc_env_allow=".*"/rc_env_allow="\*"/g' \
        # Start crashed services
        -e 's/#rc_crashed_stop=.*/rc_crashed_stop=NO/g' \
        -e 's/#rc_crashed_start=.*/rc_crashed_start=YES/g' \
        # Define extra dependencies for services
        -e 's/#rc_provide=".*"/rc_provide="loopback net"/g' \
        /etc/rc.conf \
    # Remove unnecessary services
    && rm -f /etc/init.d/hwdrivers \
            /etc/init.d/hwclock \
            /etc/init.d/hwdrivers \
            /etc/init.d/modules \
            /etc/init.d/modules-load \
            /etc/init.d/modloop \
    # Can't do cgroups
    && sed -i 's/\tcgroup_add_service/# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

# PHP installation.
RUN mkdir -p /var/log/php \
    && /sbin/apk add --update --no-cache php7-fpm php7-pecl-xdebug;

# Nginx installation.
RUN /sbin/apk add --update --no-cache nginx nginx-mod-http-echo \
    && echo 'fastcgi_param MAGE_RUN_CODE $mage_run_code;' >> /etc/nginx/fastcgi_params;

# MSMTP installation (needed for email sending)
RUN /sbin/apk add --update --no-cache msmtp

# Magento2 php dependencies
RUN /sbin/apk add --update --no-cache composer patch php7-bcmath php7-curl php7-ctype php7-dom php7-fileinfo php7-ftp php7-gd php7-gmp php7-iconv php7-intl php7-pdo_mysql php7-session php7-simplexml php7-soap php7-sodium php7-tokenizer php7-xml php7-xsl  php7-xmlwriter php7-zip

# Magerun 2 installation
RUN wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/magerun \
    && chmod a+x /usr/local/bin/magerun

# Grunt installation
RUN /sbin/apk add --update --no-cache npm \
    && npm -g install grunt-cli;

# MySQL client (not mandatory but useful)
RUN /sbin/apk add --update --no-cache mysql-client;

# Copy filesystem rewrites.
COPY rootfs /

# Run needed services.
RUN /sbin/rc-update add php-fpm7;
RUN /sbin/rc-update add nginx;

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

WORKDIR /var/www
ENTRYPOINT ["/sbin/init"]
