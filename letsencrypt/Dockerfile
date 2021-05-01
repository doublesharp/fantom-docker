FROM alpine:3.13

RUN set -xe; \
  # install dependencies
  apk add --no-cache \
  bash busybox-initscripts busybox-suid py3-pip; \
  # install build dependencies
  apk add --no-cache --virtual .build-deps \
  gcc linux-headers libffi-dev musl-dev rust cargo openssl-dev python3-dev; \
  # update pip, acme, 
  pip install --upgrade pip acme; \
  # install certbot/cloudflare 
  pip install certbot-dns-cloudflare; \
  # remove build dependencies
  apk del .build-deps; \
  # turn on cron service
  rc-update add crond;

COPY rootfs/usr/local/bin/* /usr/local/bin/
COPY rootfs/initjobs.d/jobs.txt /initjobs.d/jobs.txt

# Configure the cloudflare secrets
ENTRYPOINT [ "entrypoint.sh" ]

# Run the command on container startup
CMD ["cron.sh"]