#!/bin/bash

set -e

META_DB_PROJECT=${META_DB_PROJECT:-~/Workspace/GitLab/mip-private/meta-db}

rsync -ar --delete --exclude=".keep" --exclude=".git" $META_DB_PROJECT/ src/meta-db/

if [ -z "$@" ]; then
  vagrant up
else
  vagrant $@
fi
