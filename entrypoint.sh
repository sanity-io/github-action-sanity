#!/bin/sh

set -e

sh -c "sanity install && SANITY_AUTH_TOKEN=$SANITY_AUTH_TOKEN sanity $*"
