#!/bin/bash
set -e

DATACENTER=federation

./common/scripts/bootstrap.sh
ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible/ \
        -e play_dir="$(pwd)" \
        -e lib_roles_path="$(pwd)/roles" \
        -e datacenter="$DATACENTER" "$@" \
        install.yml
