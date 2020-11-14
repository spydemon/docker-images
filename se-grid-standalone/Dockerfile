FROM spydemon/alpn312-x11:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Installation of the Selenium server and chromedriver.
RUN apk add --update --no-cache chromium chromium-chromedriver openjdk11
RUN wget 'https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar' -O /opt/selenium.jar;

# Copy filesystem rewrites.
COPY rootfs /

RUN /sbin/rc-update add selenium;

ENTRYPOINT ["/sbin/init"]