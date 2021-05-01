FROM nginx:1-alpine

RUN set -xe; \
    apk add --no-cache --update \
    bash openssl ca-certificates busybox-suid; \
    mkdir -p /etc/ssl/certs; \
    cd /etc/ssl/certs; \
    openssl dhparam -dsaparam -out dhparam.pem 4096;

# copy to /etc (move to /usr with copy later...)
COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY rootfs/usr/nginx/conf.d/default.conf /usr/nginx/conf.d/default.conf
COPY rootfs/etc/nginx/includes/* /etc/nginx/includes/

# this will merge environment vars and start NGINX
COPY rootfs/usr/local/bin/* /usr/local/bin/

# go go go
ENTRYPOINT [ "entrypoint.sh" ]

# go go go
CMD [ "run.sh" ]
