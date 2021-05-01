#!/usr/bin/env bash

echo "📝 Merging environment variables to configuration"

for f in /usr/nginx/conf.d/*; do
  f_new=$(echo "$f" | sed 's?^/usr?/etc?')
  cat "$f" |
    sed -e 's/[$]/£/g' |
    sed -e 's/§/$/g' |
    envsubst |
    sed -e 's/£/$/g' >"$f_new"
done

echo "✅ Checking configuration"
nginx -t

if [[ "" == "$@" ]]; then
  exec "run.sh"
else
  exec "$@"
fi
