#!/bin/sh

git submodule sync
git submodule update --init

cd roles
git pull origin master
IN_SUBMODULE=true ./after-update.sh
