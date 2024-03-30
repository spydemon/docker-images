FROM spydemon/alpn319-x11
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Installation of the Selenium server and chromedriver.
RUN apk add --update --no-cache chromium chromium-chromedriver openjdk11
RUN wget 'https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.19.0/selenium-server-4.19.1.jar' -O /opt/selenium.jar;

# Copy filesystem rewrites.
COPY rootfs /

RUN /sbin/rc-update add selenium;

ENTRYPOINT ["/sbin/init"]