#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for zcoind"

  set -- zcoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "zcoind" ]; then
  mkdir -p "$ZCOIN_DATA"
  chmod 700 "$ZCOIN_DATA"
  chown -R zcoin "$ZCOIN_DATA"

  echo "$0: setting data directory to $ZCOIN_DATA"

  set -- "$@" -datadir="$ZCOIN_DATA"
fi

if [ "$1" = "zcoind" ] || [ "$1" = "zcoin-cli" ] || [ "$1" = "zcoin-tx" ]; then
  echo
  exec su-exec zcoin "$@"
fi

echo
exec "$@"
