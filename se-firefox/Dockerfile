FROM spydemon/alpn312-x11:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Selenium installation starts here.
# We install firefox and the geckodriver needed for interacting with it.
RUN apk add --update --no-cache firefox
RUN wget 'https://github.com/mozilla/geckodriver/releases/download/v0.28.0/geckodriver-v0.28.0-linux64.tar.gz' -O /opt/geckodriver.tar.gz \
    && cd /opt \
    && tar xvzf /opt/geckodriver.tar.gz

# Copy filesystem rewrites.
COPY rootfs /

RUN /sbin/rc-update add geckodriver;

ENTRYPOINT ["/sbin/init"]
