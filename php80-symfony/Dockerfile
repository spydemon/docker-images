FROM spydemon/php80:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Laravel dependencies
RUN /sbin/apk add --update --no-cache composer php8-curl php8-ctype php8-dom php8-fileinfo php8-gd php8-intl php8-mbstring php8-mysqli php8-openssl php8-pecl-imagick php8-pdo_mysql php8-session php8-simplexml php8-tokenizer php8-xml php8-xmlwriter

# It seems that
RUN rm /usr/bin/php; ln -s /usr/bin/php8 /usr/bin/php

ENTRYPOINT ["/sbin/init"]
