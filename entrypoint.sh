#!/bin/sh

set -e

if [ -z "$SANITY_AUTH_TOKEN" ]; then
  echo "Please set the secret SANITY_AUTH_TOKEN environment variable."
  exit 126
fi

if [ -n "$SANITY_STUDIO_CONFIG_PATH" ]; then
  cd "$SANITY_STUDIO_CONFIG_PATH"
fi

sh -c "SANITY_AUTH_TOKEN='$SANITY_AUTH_TOKEN' sanity $*"
