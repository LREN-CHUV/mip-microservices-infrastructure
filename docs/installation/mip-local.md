# Installation of MIP Local

## Preparation of the infrastructure project

Prepare a clone of mip-microservices-infrastructure to store the configuration for your environment and apply custom tweaks without breaking the mainline MIP project.

```
  git clone https://github.com/HBPMedical/mip-microservices-infrastructure.git my-infrastructure
```

Install Ansible and git-crypt on the machine that you will use for deployment (it can be the machine where MIP Local will be deployed, or another machine that has SSH access to the target server).

```
  cd my-infrastructure
  ./common/scripts/bootstrap.sh
```

Prepare the configuration for installation.

```
  ./common/scripts/configure-mip-local.sh

```

Store the configuration in Git, encrypt the passwords and confidential information associated to the host(s).

```
  git-crypt init
  git add .
  git commit -m "Configuration for MIP Local"

```

Perform the installation of MIP Local

```
  DATACENTER=mip-local ./setup.sh
```
