FROM spydemon/php74:0.1
LABEL maintainer="jsaipakoimetr@spyzone.fr"

# Laravel dependencies
RUN /sbin/apk add --update --no-cache composer php7-ctype php7-curl php7-dom php7-fileinfo php7-gd php7-intl php7-mbstring php7-mysqli php7-openssl php7-pecl-imagick php7-pdo_mysql php7-pdo_pgsql php7-session php7-simplexml php7-tokenizer php7-xml php7-xmlwriter yarn

ENTRYPOINT ["/sbin/init"]
