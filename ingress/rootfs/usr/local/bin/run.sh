#!/usr/bin/env bash

set -e

echo "✅ Checking configuration"
nginx -t

if [ -z "${NGINX_DEBUG}" ]; then
  echo "🌥️ Starting NGINX"
  nginx -g 'daemon off;'
else
  echo "⛈️ Starting NGINX DEBUG"
  nginx-debug -g 'daemon off;'
fi
