# Installation of MIP Local


## Requirements

- Matlab (2016b) is required by the Data Factory. The configuration script will ask for the installation path.
- As of July 5, the jmespath python library needs to be installed manually (sudo apt install python-jmespath). This should soon be covered by the deployment script.


## Configuration and installation of MIP Local

- Prepare a clone of mip-microservices-infrastructure to store the configuration for your environment and apply custom tweaks without breaking the mainline MIP project.

```
  git clone https://github.com/HBPMedical/mip-microservices-infrastructure.git my-infrastructure
```

- Prepare the configuration for installation.

```
  cd my-infrastructure
  ./common/scripts/configure-mip-local.sh
```
See below for more information on the configuration parameters

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

The Data Factory requires Matlab installed. If Matlab is not available, MIP Local can be installed without the Data Factory.

-> /usr/local/MATLAB/R2016b



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
-> 10.0.2.15

Target server IP address:
-> 10.0.2.15

Base URL for the frontend, for example http://myserver.myorg.com:7000
-> http://MAC87A3098002.dyn.epfl.ch:2223
== Address accessible on the network. For a VM, host address with port mapped to the VM port 80.Username on Gitlab to download private Docker images. Leave blank if you do not have access to this information:
-> dianeperez
Password on Gitlab to download private Docker images. Leave blank if you do not have access to this information:
-> *password*

Generate the PGP key for this user...
[details]
Please select what kind of key you want:
 (1) RSA and RSA (default)
 (2) DSA and Elgamal
 (3) DSA (sign only)
 (4) RSA (sign only)
Your selection? -> default
default options
Diane Perez
diane.perez@epfl.ch
-
testinstallinVM


git add .
git commit -m "Configuration for MIP Local"

DATACENTER=mip-local ./setup.sh
