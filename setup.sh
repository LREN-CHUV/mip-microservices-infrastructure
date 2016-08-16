#!/bin/bash

DATACENTER=federation
REMOTE_USER=$USER

./common/scripts/bootstrap.sh
ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible/ \
        -e play_dir=$(pwd) \
        -e docker_registry_config_orig_dir=$(pwd)/envs/federation \
        -e datacenter=$DATACENTER $@ \
        install.yml
