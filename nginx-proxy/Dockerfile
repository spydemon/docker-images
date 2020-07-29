FROM jwilder/nginx-proxy:alpine
LABEL maintainer="jsaipakoimetr@spyzone.fr"

COPY rootfs /

# Set a PS1 that also prompt container name.
ENV PS1="\h:\w \\$ "

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
