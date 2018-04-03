# Installation of MIP Local

## Requirements

- Matlab (2016b) is required by the Data Factory. The configuration script will ask for the installation path.

- The MIP requires using a machine with Ubuntu 16.04 or Redhat 7.2+/Centos.
   The machine can be physical, a VM in a cloud or a VirtualBox on your desktop, although in some setups, particularly with VirtualBox, you can experience difficulties related to networking.

- As Ansible requires Python 2, please install it on the target machines if needed and ensure that `/usr/bin/python` points to it. You might want to run the following command: `apt install python2.7 && ln -s /usr/bin/python2.7 /usr/bin/python`. Also, if you deploy on a remote machine, ensure that
you've installed the `jmespath` library on your machine (see common/scripts/requirements.txt).

- Network setup: it is important that the installation of MIP can be registered under a fixed IP address exposed to the local network and ideally you should provide a DNS alias for the web portal.
  The DNS alias will be used by end-users of the application who will be able to access it under a URL such as http://mip.myhospital.eu

- Security: it is the responsibility of the hosting party to secure access to MIP at the network level. TODO: link to network specs
  If an SSL key is provided, we can configure the NGinx web server provided in the platform to use secure HTTPS connections.
  In addition, we can generate an OpenID access key and configure MIP Local to use the OpenID authentication server provided by [Human Brain Project](services.humanbrainproject.eu/oidc/).

## Preparation of the infrastructure project

- Prepare a clone of mip-microservices-infrastructure to store the configuration for your environment and apply custom tweaks without breaking the mainline MIP project.

```sh
  git clone https://github.com/HBPMedical/mip-microservices-infrastructure.git my-infrastructure

  # Advanced use, to keep track of MIP versions and uptream changes
  git clone --origin mmsi --branch 2.6.0 https://github.com/HBPMedical/mip-microservices-infrastructure.git my-infrastructure
  cd my-infrastructure
  git checkout -b master
  # Backup the infrastructure projet on a private Git repository on Gitlab.com for example
  git remote add origin git@gitlab.com:hbpmip_deployment/my-infrastructure.git
```

- Prepare the configuration for installation.

```sh
  cd my-infrastructure
  ./common/scripts/configure-mip-local.sh
```

See below for more information on the configuration parameters.

- Store the configuration in Git, encrypt the passwords and confidential information associated to the host(s).

```sh
  git-crypt init
  git add .
  git commit -m "Configuration for MIP Local"

```

- Perform the installation of MIP Local

```sh
  ./setup.sh
```

## Configuration parameters

All parameters are listed here, with relevant comments where applicable.

```
Where will you install MIP Local?
1) This machine
2) A remote server

Does sudo on this machine require(s) a password?
1) yes
2) no

Which components of MIP Local do you want to install?
1) All
2) No Data Factory

Is Matlab 2016b installed on this machine?
1) yes
2) no

Enter the root of Matlab installation, e.g. ...
```

-> /usr/local/MATLAB/R2016b

The Data Factory requires Matlab installed. If Matlab is not available, MIP Data Factory can
be installed without Matlab and SPM, but those sotfware will be required to be able
to execute neuroimaging pipelines.

When you have installed MATLAB on the machine, you will need to define the configuration
setting 'matlab_root' in file envs/mip-local/etc/ansible/group_vars/data-factory and launch

```sh
  ./setup.sh --tags=data-factory
```

to complete the installation.

```
TASK [Suggested target server hostname]***********************
ok: [localhost] => {
	"ansible_hostname": "test-mip-local"
}

TASK [Suggested target server FQDN]***************************
ok: [localhost] => {
	"ansible_fqdn": "test-mip-local.epfl.ch"
}

TASK [Suggested target server IP address]***********************
ok: [localhost] => {
	"msg": "10.0.2.15"
}

Target server hostname, e.g. myserver . Use ansible_hostname value if you agree with it.
-> test-mip-local

Target server FQDN, e.g. myserver.myorg.com . If the full server name cannot be reached by DNS (ping myserver.myorg.com fails), you can use the IP address instead:
-> test-mip-local.epfl.ch

Target server IP address:
-> 10.0.2.15

Base URL for the frontend, for example http://myserver.myorg.com:7000
-> http://test-mip-local.epfl.ch
== Address accessible on the network. For a VM, host address with port mapped to the VM port 80.

Username on Gitlab to download private Docker images. Leave blank if you do not have access to this information:
-> hbp_mip
Password on Gitlab to download private Docker images. Leave blank if you do not have access to this information:
-> *password*
```

```
Generate the PGP key for this user...
[details]
Please select what kind of key you want:
 (1) RSA and RSA (default)
 (2) DSA and Elgamal
 (3) DSA (sign only)
 (4) RSA (sign only)
Your selection? -> default
default options
John Doe
John.Doe@institution.org
-

git add .
git commit -m "Configuration for MIP Local"

DATACENTER=mip-local ./setup.sh
```

After setup is complete, you should encrypt your local files to protect sensitive information such as passwords from spying.

```sh
  > git-crypt lock
  > cat envs/mip-local/etc/ansible/host_vars/localhost
  GITCRYPT�ۚ7��Q ... binary blob
```

Do not forget to unencrypt the local repository before running setup.sh after some configuration change or software

```sh
  > git-crypt unlock
  > ./setup.sh
```

## Backup of the installation scripts

The installation scripts at this point contain all the information required to install and configure your installation of MIP Local.

Sensitive information is encrypted using git-crypt - but please double check that this is is the case. For example,
file envs/mip-local/etc/ansible/host_vars/localhost should contain the passwords.

```sh
  # Use this command to check that a file containing sensitive information will be encrypted using git-crypt
  > git check-attr -a envs/mip-local/etc/ansible/host_vars/localhost
  envs/mip-local/etc/ansible/host_vars/localhost: diff: git-crypt
  envs/mip-local/etc/ansible/host_vars/localhost: text: auto
  envs/mip-local/etc/ansible/host_vars/localhost: filter: git-crypt

  # or use this command which should show the following file as encrypted
  > git-crypt status | grep -v ^not
      encrypted: envs/mip-local/etc/ansible/host_vars/localhost
```

You can create a backup of the installation and configuration to an external server.

The MIP team uses a private storage space on Gitlab.com (also some legacy BitBucket.org private repositories):

```sh
  git remote add origin git@gitlab.com:hbpmip_private/[my]-infrastructure.git
  git push -u master origin
```

Using this private repository, it is possible to safely and securely backup your work, share it with other members of MIP for code review and receive upgrades of the platform.

You private information is sent to the cloud in a secure and encrypted form that only you or people that you granted access to using strong PGP encryption can see.
