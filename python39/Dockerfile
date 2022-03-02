# The image is based on Debian and not on Alpine since SQLAlchemy seems incompatible with Musl. Indeed, the following
# error occurs when we try to run SQL migration on it:
# ImportError: Error loading shared library libresolv.so.2: No such file or directory (needed by /var/www/vendor/lib/
# python3.9/site-packages/psycopg2/../psycopg2_binary.libs/libgssapi_krb5-497db0c6.so.2.2)

FROM python:3.9
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

# Copy filesystem rewrites.
COPY rootfs /

WORKDIR /var/www

ENTRYPOINT ["bash",  "/sbin/while_loop"]