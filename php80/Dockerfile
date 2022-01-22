FROM alpine:3.15
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

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

# PHP installation.
RUN mkdir -p /var/log/php \
    && /sbin/apk add --update --no-cache php8 php8-fpm php8-pecl-xdebug;

# Nginx installation.
RUN /sbin/apk add --update --no-cache nginx nginx-mod-http-echo;

# MSMTP installation (needed for email sending)
RUN /sbin/apk add --update --no-cache msmtp

# Copy filesystem rewrites.
COPY rootfs /

# Run needed services.
RUN /sbin/rc-update add php-fpm8;
RUN /sbin/rc-update add nginx;

WORKDIR /var/www
ENTRYPOINT ["/sbin/init"]
