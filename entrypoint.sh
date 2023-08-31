#!/bin/sh

set -e

if [ -z "$SANITY_AUTH_TOKEN" ]; then
  echo "Please set the secret SANITY_AUTH_TOKEN environment variable."
  exit 1
fi

SANITY_AUTH_TOKEN='$SANITY_AUTH_TOKEN' npx sanity $*
