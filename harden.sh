#!/bin/sh

echo "Harden the managed servers"

# Reference:
# http://geekeasier.com/protect-ssh-server-with-installing-fail2ban-on-linuxubuntu/3774/

[ -d .git-crypt ] || (
    git crypt init
    git-crypt add-gpg-user ludovic.claude@chuv.ch
    echo "Setup .gitattributes, see https://www.agwa.name/projects/git-crypt/"
    echo "Check that your files are well protected using"
    echo "  git check-attr -a <path to file to encrypt>"
    echo "The file should have diff: git-crypt and filter: git-crypt present"
)

DATACENTER=main

ansible-playbook --ask-become-pass -i envs/$DATACENTER/etc/ansible/ \
        -e play_dir=$(pwd) \
        -e datacenter=$DATACENTER \
        common/playbooks/secure-system.yml
