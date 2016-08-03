## QA-Tools demo

### Installation:

* install [Ansible](https://www.ansible.com/), on Ubuntu you can use the script ./common/scripts/bootstrap.sh
* install [Vagrant](https://www.vagrantup.com/)
* start the virtual machine with Vagrant
  ```
    vagrant up
  ```

### Usage:

The virtual machine should start and install the QA-Tools (Jenkins, SonarQube, Artifactory, OpenLDAP, ...).

Marathon can be accessed on [localhost:15080](http://localhost:15080)

Mesos can be accessed on [localhost:15050](http://localhost:15050)
