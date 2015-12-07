#!/bin/sh

echo "Harden the managed servers"

DATACENTER=main

ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible.security/ \
        -e play_dir=$(pwd) \
        -e datacenter=$DATACENTER \
        common/playbooks/secure-system.yml
