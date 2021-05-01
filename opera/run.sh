#!/usr/bin/env sh

set -e

# start opera with genesis file
echo "starting opera"
opera \
  --http \
  --http.addr "0.0.0.0" \
  --http.api "${FANTOM_API}" \
  --http.vhosts "${FANTOM_HOSTNAME}" \
  --nousb \
  --verbosity ${FANTOM_VERBOSITY} \
  --cache ${FANTOM_CACHE} \
  --genesis /genesis/${FANTOM_GENESIS}
