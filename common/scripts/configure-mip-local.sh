#!/usr/bin/env bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"

     while [ -h "$SOURCE" ]; do
          # shellcheck disable=SC2091
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     cd -P "$( dirname "$SOURCE" )"
     pwd
}

ROOT=$(get_script_dir)
cd "$ROOT/../.."

ANSIBLE_OPTS=""
target=""

mkdir -p envs/mip-local/etc/ansible/

echo "Where will you install MIP Local?"
PS3='> '
options=("This machine" "A remote server")
select location in "${options[@]}";
do
  case "$location" in
      "This machine")
          ANSIBLE_OPTS="-e mip_install=local -e target_server=localhost"
          target="this machine"
          cat <<EOF > envs/mip-local/etc/ansible/hosts
[all]
localhost ansible_connection=local

[managed]
localhost
EOF
          ;;
      "A remote server")
          echo
          echo "Please provide the connection information to the server"
          echo "An SSH access using public key authentication must be available."
          echo "Use ssh-copy-id to add your public key to the remote server"
          read -p "Server DNS > " server_dns
          read -p "Server login user > " server_user
          ANSIBLE_OPTS="-e mip_install=remote -e target_server=$server_dns -e server_user=$server_user"
          target="$server_dns"
          cat <<EOF > envs/mip-local/etc/ansible/hosts
[all]
$server_dns ansible_connection=ssh ansible_ssh_host=$server_dns ansible_ssh_user=$server_user

[managed]
$server_dns
EOF
          ;;
        *)
          echo invalid option
          exit 1
          ;;
  esac
  break
done

echo "Does sudo on $target requires a password?"
PS3="> "
options=("yes" "no")
select sudo_pwd in "${options[@]}";
do
  case "$sudo_pwd" in
      "yes")
          ANSIBLE_OPTS="$ANSIBLE_OPTS --become --ask-become-pass"
          ;;
      "no")
          ANSIBLE_OPTS="$ANSIBLE_OPTS --become"
          ;;
        *)
          echo invalid option
          exit 1
          ;;
  esac
  break
done

echo
echo "Which components of MIP Local do you want to install?"
PS3='> '
options=("All" "No Data Factory")
select building_blocks in "${options[@]}";
do
  case "$building_blocks" in
    "All")
        ANSIBLE_OPTS="$ANSIBLE_OPTS -e mip_building_blocks=all"
        ;;
    "No Data Factory")
        ANSIBLE_OPTS="$ANSIBLE_OPTS -e mip_building_blocks=!df"
        ;;
    *)
        echo invalid option
        exit 1
        ;;
  esac
  break
done

echo
echo "Generating the configuration for MIP Local..."
echo "Additional informations will be asked, including a long list of passwords for the databases."
echo "Please keep this information safe."
echo
if [ "$sudo_pwd" == "yes" ]; then
  echo "Please enter the sudo password for the target server"
  echo
fi

# shellcheck disable=SC2086
ansible-playbook $ANSIBLE_OPTS \
        -i envs/mip-local/etc/ansible \
        -e play_dir="$(pwd)" \
        -e lib_roles_path="$(pwd)/roles" \
        -e datacenter="mip-local" \
        common/playbooks/generate-mip-local-config.yml

echo "DATACENTER=mip-local" > .environment

mkdir -p .not-used

[ -f circle.yml ] && git mv circle.yml .not-used/
