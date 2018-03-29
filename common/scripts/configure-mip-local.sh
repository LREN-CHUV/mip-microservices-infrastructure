#!/usr/bin/env bash
# shellcheck disable=SC2162

#
# Configure an installation of MIP Local on this machine or on a remote machine accessible by SSH.
#

set -e

debug=false
if [ "$1" == "--debug" ]; then
  debug=true
fi

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

which ansible > /dev/null || ./common/scripts/bootstrap.sh

ANSIBLE_OPTS=()
SETUP_ANSIBLE_OPTS=()
target=""

mkdir -p envs/mip-local/etc/ansible/

echo
echo "** Generic configuration **"
echo
echo "Where will you install MIP Local?"
PS3='> '
options=("This machine" "A remote server")
select location in "${options[@]}";
do
  case "$location" in
      "This machine")
          ANSIBLE_OPTS+=("-e mip_install=local")
          ANSIBLE_OPTS+=("-e target_server=localhost")
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
          read -p "Server SSH port (usually 22) > " server_ssh_port
          ANSIBLE_OPTS+=("-e mip_install=remote")
          ANSIBLE_OPTS+=("-e target_server=$server_dns")
          ANSIBLE_OPTS+=("-e server_user=$server_user")
          target="$server_dns"
          cat <<EOF > envs/mip-local/etc/ansible/hosts
[all]
$server_dns ansible_connection=ssh ansible_ssh_host=$server_dns ansible_ssh_user=$server_user ansible_ssh_port=${server_ssh_port:-22}

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
          ANSIBLE_OPTS+=("--become")
          ANSIBLE_OPTS+=("--ask-become-pass")
          ;;
      "no")
          ANSIBLE_OPTS+=("--become")
          ;;
        *)
          echo invalid option
          exit 1
          ;;
  esac
  break
done

declare -A mip_building_blocks
# shellcheck disable=SC2154
{
  mip_building_blocks["dc"]=true
  mip_building_blocks["df"]=true
  mip_building_blocks["af"]=true
  mip_building_blocks["hdb"]=true
  mip_building_blocks["ref"]=true
  mip_building_blocks["wa"]=true
}

echo
echo "Which components of MIP Local do you want to install?"
PS3='> '
options=("All" "Web analytics and databases only" "Data Factory only")
select building_blocks in "${options[@]}";
do
  case "$building_blocks" in
    "All")
        ;;
    "Web analytics and databases only")
        unset mip_building_blocks['dc']
        unset mip_building_blocks['df']
        ;;
    "Data Factory only")
        unset mip_building_blocks["dc"]
        unset mip_building_blocks["af"]
        unset mip_building_blocks["hdb"]
        unset mip_building_blocks["ref"]
        unset mip_building_blocks["wa"]
        ;;
    *)
        echo invalid option
        exit 1
        ;;
  esac
  break
done

if [[ "${mip_building_blocks['wa']}" == "true" ]]; then
  echo
  echo "What is the name of this instance of MIP? It will be displayed on the web front-end."
  read -p " > " mip_instance_name
  ANSIBLE_OPTS+=("-e mip_instance_name='${mip_instance_name:-MIP Local}'")
fi

echo
echo "** Configuration of datasets **"
echo

echo "Please enter an id for the main dataset to process, e.g. 'demo' and a readable label for it, e.g. 'Demo data'"
read -p "Id for the main dataset > " main_dataset_id
read -p "Label for the main dataset > " main_dataset_label
ANSIBLE_OPTS+=("-e main_dataset_id='${main_dataset_id:-demo}'")
ANSIBLE_OPTS+=("-e main_dataset_label='${main_dataset_label:-demo}'")

if [[ "${mip_building_blocks['hdb']}" == "true" ]]; then
  echo
  echo "** Configuration of databases **"
  echo
  echo "Do you want to store research-grade data in CSV files or in a relational database?"
  PS3='> '
  options=("CSV files" "Relational database")
  select building_blocks in "${options[@]}";
  do
    case "$building_blocks" in
      "CSV files")
          ANSIBLE_OPTS+=("-e features_from=ldsm-db")
          ;;
      "Relational database")
          unset mip_building_blocks['hdb']
          ANSIBLE_OPTS+=("-e features_from=research-db")
          ;;
      *)
          echo invalid option
          exit 1
          ;;
    esac
    break
  done
fi


if [[ "${mip_building_blocks['df']}" == "true" ]]; then
  echo
  echo "** Configuration of Data Factory for MRI preprocessing and data integration **"
  echo
  echo "Please enter the directory for incoming data."
  echo "It will be used to host incoming files and work files. Default is '/var/mip'"
  read -p "Directory for incoming data > " df_incoming_dir
  ANSIBLE_OPTS+=("-e df_incoming_dir='${df_incoming_dir:-/var/mip}'")
  echo
  echo "New data for the main dataset should be put under ${df_incoming_dir:-/var/mip}/${main_dataset_id:-demo}"
  echo

  echo "Please enter the work directory for the Data Factory."
  echo "It will be used to host incoming files and work files. Default is '/var/tmp/mip'"
  read -p "Work directory for Data Factory > " df_work_dir
  ANSIBLE_OPTS+=("-e df_work_dir='${df_work_dir:-/var/tmp/mip}'")

  if [[ "$location" == "This machine" && ! -d /usr/local/MATLAB/2016b ]]; then
      echo "Is Matlab 2016b installed on this machine?"
      PS3="> "
      options=("yes" "no")
      select matlab_installed in "${options[@]}";
      do
        case "$matlab_installed" in
            "yes")
                echo "Enter the root of Matlab installation, e.g. /opt/MATLAB/2016b :"
                read -p "path > " matlab_root
                ANSIBLE_OPTS+=("-e matlab_root=$matlab_root")
                ;;
            "no")
                SETUP_ANSIBLE_OPTS+=("--skip-tags=spm")
                echo "The Data Factory will be installed but image pre-processing will not be functional."
                echo "When Matlab is available, please run again the installation to setup Matlab and SPM using:"
                echo "  ./setup.sh --tags=data-factory"
                echo
                ;;
              *)
                echo invalid option
                exit 1
                ;;
        esac
        break
      done
  fi

  echo "Do you want to send progress and alerts on data processing to a Slack channel?"
  PS3="> "
  options=("yes" "no")
  select use_slack in "${options[@]}";
  do
    case "$use_slack" in
        "yes")
            echo "To enable Slack, please enter the name of the channel and the Slack token"
            read -p "Slack channel, e.g. #data > " slack_channel
            read -p "Slack API token > " slack_token
            if [[ -n "$slack_channel" && -n "$slack_token" ]]; then
              ANSIBLE_OPTS+=("-e slack_channel='$slack_channel'")
              ANSIBLE_OPTS+=("-e slack_token='$slack_token'")
            else
              echo "You did not filled all required information. Slack notifications are disabled"
            fi
            ;;
        "no")
            ;;
          *)
            echo invalid option
            exit 1
            ;;
    esac
    break
  done

fi

if [[ "${mip_building_blocks['wa']}" == "true" ]]; then
  echo
  echo "** Configuration of Web portal **"
  echo
  echo "Do you want to secure access to the local MIP Web portal?"
  PS3="> "
  options=("yes" "no")
  select portal_security in "${options[@]}";
  do
    case "$portal_security" in
        "yes")
            echo "To enable portal security, please enter the HBP Client ID and Client secret"
            read -p "HBP Client ID > " hbp_client_id
            read -p "HBP Client secret > " hbp_client_secret
            if [[ -n "$hbp_client_id" && -n "$hbp_client_secret" ]]; then
              ANSIBLE_OPTS+=("-e portal_backend_hbp_client_id=$hbp_client_id")
              ANSIBLE_OPTS+=("-e portal_backend_hbp_client_secret=$hbp_client_secret")
            else
              echo "You did not filled all required information. Security is disabled"
            fi
            ;;
        "no")
            ;;
          *)
            echo invalid option
            exit 1
            ;;
    esac
    break
  done

  echo "To enable Google analytics, please enter the Google tracker ID or leave this blank to disable it"
  read -p "Google tracker ID > " google_tracker_id
  ANSIBLE_OPTS+=("-e portal_frontend_google_tracker_id=$google_tracker_id")
fi

ANSIBLE_OPTS+=("-e mip_building_blocks=$(echo "${!mip_building_blocks[@]}" | tr ' ' ',')")

# Move uptream files aside, to avoid Git conflicts with locally generated files during Git merges
mkdir -p .not-used
[ -f MIP-README.md ] || git mv README.md MIP-README.md
[ -f .not-used/setup.sh ] || git mv setup.sh .not-used/setup.sh
[ -f .not-used/slack.json ] || git mv slack.json .not-used/slack.json

echo
echo "Generating the configuration for MIP Local..."
echo
if [ "$sudo_pwd" == "yes" ]; then
  echo "Please enter the sudo password for the target server"
  echo
fi

if [ "$debug" == "true" ]; then
  set -x
fi

ansible-playbook "${ANSIBLE_OPTS[@]}" \
        -i envs/mip-local/etc/ansible \
        -e play_dir="$(pwd)" \
        -e lib_roles_path="$(pwd)/roles" \
        -e datacenter="mip-local" \
        common/playbooks/generate-mip-local-config.yml

set +x

echo "DATACENTER=mip-local" > .environment

mkdir -p .not-used

[ -f circle.yml ] && git mv circle.yml .not-used/

which gpg > /dev/null || (
  echo "Installing gnupg..."
  if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -y install gnupg
  else
    sudo yum -y install gnupg
  fi
)

[ -f ~/.gnupg/pubring.gpg ] || (
  echo "Installing haveged..."
  if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -y install haveged
  else
    sudo yum -y install haveged
  fi
  echo "Generate the PGP key for this user..."
  gpg --gen-key
  echo "Uninstall haveged..."
  if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -y remove haveged
  else
    sudo yum -y uninstall haveged
  fi
)

[ -d .git/git-crypt ] || git-crypt init
if [ -z $(git config user.email) ]; then
  git config user.email "deployment@script"
  git config user.name "deployment@script"
fi
gpg --list-secret-keys | grep '^uid' | sed s/'uid\s\+\(.*\)'/'\1'/ | while read keyid; do
  git-crypt add-gpg-user "$keyid"
done

git add .

echo
echo "Generation of the standard configuration for MIP Local complete!"
echo
echo "You can review the configuration located in $ROOT/envs/mip-local/etc/ansible/"
echo "and customise it further for your environment and needs."
echo "More information about the configuration settings can be found in"
echo "  $ROOT/docs/configuration/"
echo
echo "Before starting the installation, please commit the configuration in Git:"
echo "  git commit -m 'Configuration for MIP Local'"
echo
echo "Then run setup.sh to start the installation"
echo "  ./setup.sh ${SETUP_ANSIBLE_OPTS[*]}"
