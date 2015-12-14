#!/bin/sh

echo "Harden the managed servers"

# Reference:
# http://geekeasier.com/protect-ssh-server-with-installing-fail2ban-on-linuxubuntu/3774/

DATACENTER=main

ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible.security/ \
        -e play_dir=$(pwd) \
        -e datacenter=$DATACENTER \
        common/playbooks/secure-system.yml
