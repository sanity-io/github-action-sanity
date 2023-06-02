#!/bin/bash

set -e

sh -c "cd $1 && sanity install"
shift
sh -c "SANITY_AUTH_TOKEN='$SANITY_AUTH_TOKEN' sanity $*"
