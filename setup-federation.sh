#!/bin/bash

DATACENTER=federation
REMOTE_USER=$USER

./common/scripts/bootstrap.sh
 # TODO: remove skip tags docker-registry
ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible/ \
        -e play_dir=$(pwd) \
        -e docker_registry_config_orig_dir=$(pwd)/envs/federation \
        -e datacenter=$DATACENTER \
        --skip-tags=front,docker-registry \
        install.yml
