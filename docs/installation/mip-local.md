# Installation of MIP Local

## Requirements

- Matlab (2016b) is required by the Data Factory. The configuration script will ask for the installation path.

## Preparation of the infrastructure project

- Prepare a clone of mip-microservices-infrastructure to store the configuration for your environment and apply custom tweaks without breaking the mainline MIP project.

```sh
  git clone https://github.com/HBPMedical/mip-microservices-infrastructure.git my-infrastructure
```

- Prepare the configuration for installation.

```sh
  cd my-infrastructure
  ./common/scripts/configure-mip-local.sh
```

See below for more information on the configuration parameters.

- Store the configuration in Git, encrypt the passwords and confidential information associated to the host(s).

```
  git-crypt init
  git add .
  git commit -m "Configuration for MIP Local"

```

- Perform the installation of MIP Local

```
  DATACENTER=mip-local ./setup.sh
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
