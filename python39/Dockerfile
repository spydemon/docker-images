# The image is based on Debian and not on Alpine since SQLAlchemy seems incompatible with Musl. Indeed, the following
# error occurs when we try to run SQL migration on it:
# ImportError: Error loading shared library libresolv.so.2: No such file or directory (needed by /var/www/vendor/lib/
# python3.9/site-packages/psycopg2/../psycopg2_binary.libs/libgssapi_krb5-497db0c6.so.2.2)

FROM python:3.9
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

RUN apt update && apt install -y openrc \
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
    # Can't do cgroups
    && sed -i 's/\tcgroup_add_service/# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh

RUN /sbin/rc-update del hwclock.sh
RUN /sbin/rc-update del procps
RUN /sbin/rc-update del x11-common
RUN /sbin/rc-update del savecache off
RUN /sbin/rc-update del cgroups sysinit

# Copy filesystem rewrites.
COPY rootfs /

WORKDIR /var/www

RUN /sbin/rc-update add flask default;
#ENTRYPOINT ["bash",  "/sbin/while_loop"]
ENTRYPOINT ["/sbin/openrc-init"]
