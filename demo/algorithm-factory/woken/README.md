# Woken demo

Demonstration of Woken and its environment running inside a Vagrant Virtual machine.

## Installation

* install [Ansible](https://www.ansible.com/) version 2.2.0 or better. On Ubuntu you can use the script ./common/scripts/bootstrap.sh
* install [VirtualBox](https://www.virtualbox.org/) version 5.0 or better
* install [Vagrant](https://www.vagrantup.com/) version 1.8.5 or better
* install vagrant plugin install vagrant-hostmanager

  ```
     vagrant plugin install vagrant-hostmanager
  ```
* start the virtual machine with Vagrant

  ```
    vagrant up
  ```

### Troubleshooting

#### VirtualBox is complaining that the installation is incomplete

After upgrading the Linux kernel in your system you may encounter this message when running a Vagrant command:

```
The provider 'virtualbox' that was requested to back the machine
'airflow' is reporting that it isn't usable on this system. The
reason is shown below:

VirtualBox is complaining that the installation is incomplete. Please
run `VBoxManage --version` to see the error message which should contain
instructions on how to fix this error.
```

To fix it, you need to rebuild a module for Virtualbox using this command:

```
  sudo apt-get install --reinstall virtualbox-dkms linux-headers-generic
```

## Usage

The virtual machine should start and install Woken.

Woken webservices are accessible from [localhost:14087](http://localhost:14087)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

Chronos can be accessed on [localhost:14400](http://localhost:14400)

## Testing

Run the following tests using curl:

TODO: provide example data and some tests

## For developers

### Sources for Woken and related projects

| Algorithm Factory | Organisation | License | Management | Continuous integration |
|-------------------|--------------|---------|------------|------------------------|
| [woken](https://github.com/HBPMedical/woken) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/HBPMedical/woken/blob/master/LICENSE) |   |   |
| [base-docker-images](https://github.com/HBPMedical/base-docker-images) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/mip-microservices-infrastructure/blob/master/LICENSE.md) |   |   |
| [functions-repository](https://github.com/HBPMedical/functions-repository) |  [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/mip-microservices-infrastructure/blob/master/LICENSE.md) |   |   |
| [sample-datasets-db](https://github.com/HBPMedical/sample-datasets-db) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/HBPMedical/sample-datasets-db/blob/master/LICENSE) |   |   |

### Configuration for Ansible inventory

Ansible inventory controls what software is installed and how it is configured.

It is organised by hosts (servers) and groups.

Here, we have the following organisation:

* demo: the target host, running inside a Vagrant Virtual machine
* managed: a group containing demo, indicating that the server is managed by Ansible and should be applied a default configuration and a set of base sofware packages
* control: a group containing demo, indicating that this server is used to perform operations affecting the whole cluster (here we have a 'cluster' of one machine)
* zookeeper, mesos-mixed: groups that are used to define where and how the Mesos stack is deployed
* woken-db, demo-db, woken, woken-validation: groups that are used to define which applications should be deployed by Marathon

[![Inventory configuration](inventory-config.png)]()
