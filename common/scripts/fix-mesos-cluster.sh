#!/bin/bash
#
# Attempts to fix the Mesos cluster by cleaning up logs and restarting all services.
#
# There is an option (--reset) that can destroy all state in the cluster (= the list of running application
# and their current status) in an attempt to recover the clsuter after some catastrophic failure
# or loss of coherence (phantom tasks...)
#

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"

     while [ -h "$SOURCE" ]; do
          # shellcheck disable=SC2091
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     cd -P "$( dirname "$SOURCE" )" || exit
     pwd
}

ROOT="$(get_script_dir)/../.."
cd "$ROOT" || exit

DATACENTER=federation

# shellcheck disable=SC1091
[ -f .environment ] && source ./.environment

OPTS=""
if [ "$1" = "--reset" ]; then
  OPTS="$OPTS -e reset_mesos=True"
  echo "This action will destroy all applications in your cluster."
  echo "You will have to reinstall all software by running:"
  echo "    ./setup.sh --tags=marathon-app"
  echo
  echo "Please manually stop all applications using the Marathon interface before continuing"
  echo "Press enter to continue."
  # shellcheck disable=SC2162
  read -p "> "
fi

ANSIBLE_ARGS="-e ansible_connection=local"
if [ "$(hostname)" != "$HOSTNAME" ]; then
  ANSIBLE_ARGS="-e ansible_connection=ssh"
fi

# shellcheck disable=SC2086
ansible-playbook --ask-become-pass -i "$(pwd)/envs/$DATACENTER/etc/ansible/" \
        -e play_dir="$(pwd)" \
        -e datacenter="$DATACENTER" "$ANSIBLE_ARGS" $OPTS \
        "common/playbooks/infrastructure/fix-mesos-cluster.yml"
