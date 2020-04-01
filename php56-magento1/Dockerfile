FROM alpine:3.5
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Add community respository for being able to fetch php5-xdebug
RUN cat /etc/apk/repositories | grep main | sed s/main/community/ >> /etc/apk/repositories;

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
    && sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

# PHP installation.
RUN mkdir -p /var/log/php \
    && /sbin/apk add --update --no-cache php5-fpm php5-xdebug;

# Magento Magento PHP dependencies.
RUN /sbin/apk add --update --no-cache php5-ctype php5-curl php5-dom php5-gd php5-iconv php5-json php5-pdo_mysql php5-phar php5-soap php5-zlib

# Nginx installation.
RUN /sbin/apk add --update --no-confirm nginx nginx-mod-http-echo

# Copy filesystem rewrites.
COPY rootfs /

# Run needed services.
RUN /sbin/rc-update add php-fpm;
RUN /sbin/rc-update add nginx;

ENTRYPOINT ["/sbin/init"]
