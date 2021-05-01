#!/usr/bin/env bash

set -e

. /usr/local/bin/helper-functions

# as root configure your cloudflare secrets
info "🔑 configuring cloudflare secrets"
mkdir -p /root/.secrets
cat <<CLOUDFLARE_CONFIG >~/.secrets/cloudflare.ini
dns_cloudflare_email="$CLOUDFLARE_EMAIL"
dns_cloudflare_api_key="$CLOUDFLARE_API_KEY"
CLOUDFLARE_CONFIG

# make sure they are hidden, the api key is more powerful than a password!
info "🔐 securing cloudflare secrets"
chmod 0700 /root/.secrets/
chmod 0400 /root/.secrets/cloudflare.ini

# run this after the certbot renewal to copy keys to nginx
info "🤖 creating certbot-post-hook"
POST_HOOK_PATH="/usr/local/bin/certbot-post-hook"
cat <<CERTBOT_POST_HOOK >"$POST_HOOK_PATH"
# copy ssl certs and keys, should mount as a volume to persist/share
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem "/etc/nginx/ssl/$DOMAIN-fullchain.pem"
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem "/etc/nginx/ssl/$DOMAIN-privkey.pem"
CERTBOT_POST_HOOK

# make post hook executable
chmod +x "$POST_HOOK_PATH"

if [ ! -f "/etc/nginx/ssl/$DOMAIN-fullchain.pem" ]; then
  # generate the certificate
  certbot certonly \
    --quiet \
    --non-interactive \
    --agree-tos \
    --email "$CLOUDFLARE_EMAIL" \
    --keep-until-expiring \
    --preferred-challenges dns-01 \
    --dns-cloudflare \
    --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
    -d $DOMAIN
  # run the post hook
  certbot-post-hook
fi

if [[ "" == "$@" ]]; then
  exec "cron.sh"
else
  exec "$@"
fi
