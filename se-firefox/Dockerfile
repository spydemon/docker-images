FROM alpine:3.12
LABEL maintainer="jsaipakoimetr@spyzone.fr"

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
    && sed -i 's/\tcgroup_add_service /\t#cgroup_add_service /g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

RUN apk add --update --no-cache fluxbox x11vnc xvfb 

# Copy filesystem rewrites.
COPY rootfs /

ENV DISPLAY=":1"

# Run needed services.
RUN /sbin/rc-update add fluxbox;
RUN /sbin/rc-update add x11vnc;
RUN /sbin/rc-update add xvfb;

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

WORKDIR /var/www
ENTRYPOINT ["/sbin/init"]
