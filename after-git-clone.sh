#!/bin/sh

git submodule update --init

cd roles/
git submodule update --init --recursive
