#!/usr/bin/env sh

set -e

# download the genesis file
if [ -f "/genesis/${FANTOM_GENESIS}" ]; then
  echo "💼 found ${FANTOM_GENESIS}"
else
  echo "🌐 downloading genesis file ${FANTOM_GENESIS}"
  wget https://${FANTOM_NETWORK}.fantom.network/${FANTOM_GENESIS} /genesis/${FANTOM_GENESIS}
  echo "💼 using genesis file ${FANTOM_GENESIS}"
fi

if [[ "" == "$@" ]]; then
  exec "run.sh"
else
  exec "$@"
fi
