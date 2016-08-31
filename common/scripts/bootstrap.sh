#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"

     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     cd -P "$( dirname "$SOURCE" )"
     pwd
}

ROOT=$(get_script_dir)
cd $ROOT

[ -x /usr/local/bin/ansible ] || (

  # Install Ansible
  sudo apt-get install -y git python-setuptools python-yaml python-jinja2 python-paramiko python-keyczar
  sudo apt-get install -y python-pip || sudo -H easy_install pip
  sudo -H pip install -r requirements.txt
)

if [ "$1" != "--skip-git-crypt" ]; then
  [ -x /usr/bin/git ] || sudo apt-get install -y git

  [ -x /usr/bin/git-crypt ] || (
    echo "Please enter the sudo password for this local computer to install git-crypt"
    ansible-playbook --ask-become-pass -i ../../envs/install/etc/ansible ../playbooks/ansible-install.yml
  )
fi
