#!/bin/bash

set -e

META_DB_PROJECT=${META_DB_PROJECT:-~/Workspace/GitLab/mip-private/meta-db}
FEATURES_DB_PROJECT=${FEATURES_DB_PROJECT:-~/Workspace/GitLab/mip-private/adni-merge-db}

rsync -ar --delete --exclude=".keep" --exclude=".git" "$META_DB_PROJECT/" src/meta-db/
rsync -ar --delete --exclude=".keep" --exclude=".git" "$FEATURES_DB_PROJECT/" src/research-db/

if [ -z "$@" ]; then
  vagrant up
else
  vagrant "$@"
fi
