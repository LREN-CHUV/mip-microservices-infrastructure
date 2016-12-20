#!/bin/bash

set -e

mkdir dataset

if [ -z "$@" ]; then
  vagrant up
else
  vagrant $@
fi
