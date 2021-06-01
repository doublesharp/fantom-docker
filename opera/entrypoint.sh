#!/usr/bin/env ash

set -e

# download the genesis file
if [ -f "/genesis/${FANTOM_GENESIS}" ]; then
  echo "💼 found ${FANTOM_GENESIS}"
else
  echo "🌐 downloading genesis file ${FANTOM_GENESIS}"
  wget "https://${FANTOM_NETWORK}.fantom.network/${FANTOM_GENESIS}" -O "/genesis/${FANTOM_GENESIS}"
  echo "💼 using genesis file ${FANTOM_GENESIS}"
fi

if [ "" = "$*" ] || [ "run.sh" = "$*" ]; then
  echo "🦄 Starting Fantom Opera"
  exec "run.sh"
else
  echo "🦄 Starting '$@'"
  exec "$@"
fi
