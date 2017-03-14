#!/bin/bash

set -e

META_DB_PROJECT=${META_DB_PROJECT:-~/Workspace/GitLab/mip-private/meta-db}
SCIENCE_DB_PROJECT=${SCIENCE_DB_PROJECT:-~/Workspace/GitLab/mip-private/adni-merge-db}

rsync -ar --delete --exclude=".keep" --exclude=".git" "$META_DB_PROJECT/" src/meta-db/
rsync -ar --delete --exclude=".keep" --exclude=".git" "$SCIENCE_DB_PROJECT/" src/science-db/

if [ -z "$@" ]; then
  vagrant up
else
  vagrant "$@"
fi
