#!/bin/bash

set -e

sh -c "cd $1 && sanity install && SANITY_AUTH_TOKEN=$SANITY_AUTH_TOKEN sanity ${@:2:99}"
