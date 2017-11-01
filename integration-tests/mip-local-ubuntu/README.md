# MIP Local on Ubuntu

Integration test and demonstration of MIP Local running inside a Vagrant Virtual machine.

Not all processes will work, in particular Web analytics and Algorithm Factory as not enough memory is allocated.

## Installation

* install [Ansible](https://www.ansible.com/) version 2.2.0 or better. On Ubuntu you can use the script ./common/scripts/bootstrap.sh
* install [VirtualBox](https://www.virtualbox.org/) version 5.0 or better
* install [Vagrant](https://www.vagrantup.com/) version 1.8.5 or better
* install vagrant plugin install vagrant-hostmanager

  ```
     vagrant plugin install vagrant-hostmanager
  ```
* start the virtual machine with Vagrant. You will need at least 5Gb of RAM available for the VM.

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

The virtual machine should start and install Airflow.

You can see Airflow running at [localhost:14080](http://localhost:14080)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

PostgresRAW UI should be accessible from [localhost:15555](http://localhost:15555)

## Testing

Example data is provided in /data/demo folder inside the VM, but the preprocessing pipelines
cannot work at the moment as they require Matlab installed.

The ./data/ldsm folder is mapped to the Query Engine and any CSV file present in this folder will be automatically registered and visible as a table.

## For developers

### Sources for Airflow and related projects

| Deployment | Organisation | License | Management | Continuous integration |
|------------|--------------|---------|------------|------------------------|
| [ansible-airflow](https://github.com/HBPMedical/ansible-airflow) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/HBPMedical/ansible-airflow/blob/master/LICENSE) |   |

| Data Factory | Organisation | License | Planning | Continuous integration |
|--------------|--------------|---------|------------|------------------------|
| [data-tracking](https://github.com/HBPMedical/data-tracking) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/HBPMedical/data-tracking/blob/master/LICENSE) |   | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/4547fb5d1e464e4087640e046893576a)](https://www.codacy.com/app/mirco-nasuti/data-tracking?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/data-tracking&amp;utm_campaign=Badge_Grade) [![CircleCI](https://circleci.com/gh/LREN-CHUV/data-tracking.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/data-tracking) |
| [mri-meta-db](https://github.com/HBPMedical/mri-meta-db) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/mri-meta-db/blob/master/LICENSE) |   | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/9adcf4cbd730472386d0e71ab27b9b6b)](https://www.codacy.com/app/mirco-nasuti/mri-meta-db?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/mri-meta-db&amp;utm_campaign=Badge_Grade) [![CircleCI](https://circleci.com/gh/LREN-CHUV/mri-meta-db.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/mri-meta-db) |
| [mri-preprocessing-pipeline](https://github.com/HBPMedical/mri-preprocessing-pipeline) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-AGPL--3.0-blue.svg)](https://github.com/HBPMedical/mri-preprocessing-pipeline/blob/master/LICENSE) |   |   |
| [airflow-imaging-plugins](https://github.com/HBPMedical/airflow-imaging-plugins) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/HBPMedical/airflow-imaging-plugins/blob/master/LICENSE) |   | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/7a9c796392e4420495ee1fabd0fce9ae)](https://www.codacy.com/app/hbp-mip/airflow-imaging-plugins?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/airflow-imaging-plugins&amp;utm_campaign=Badge_Grade) |
| [data-factory-airflow-dags](https://github.com/HBPMedical/data-factory-airflow-dags) | [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) | [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/HBPMedical/data-factory-airflow-dags/blob/master/LICENSE) |   | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/8c5c9dc3cfb8492f870369c973f3cc8c)](https://www.codacy.com/app/hbp-mip/data-factory-airflow-dags?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/data-factory-airflow-dags&amp;utm_campaign=Badge_Grade) |

### Configuration for Ansible inventory

Ansible inventory controls what software is installed and how it is configured.

It is organised by hosts (servers) and groups.

Here, we have the following organisation:

* demo: the target host, running inside a Vagrant Virtual machine
* managed: a group containing demo, indicating that the server is managed by Ansible and should be applied a default configuration and a set of base sofware packages
* control: a group containing demo, indicating that this server is used to perform operations affecting the whole cluster (here we have a 'cluster' of one machine)
* zookeeper, mesos-mixed: groups that are used to define where and how the Mesos stack is deployed
* airflow: groups that are used to define which applications should be deployed by Marathon

[![Inventory configuration](inventory-config.png)]()
