FROM jwilder/nginx-proxy:alpine
LABEL maintainer="jsaipakoimetr@spyzone.fr"

COPY rootfs /

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
