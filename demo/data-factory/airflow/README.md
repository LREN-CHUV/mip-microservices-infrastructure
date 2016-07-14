## Airflow demo

### Installation:

* install [Ansible](https://www.ansible.com/), on Ubuntu you can use the script ./common/scripts/bootstrap.sh
* install [Vagrant](https://www.vagrantup.com/)
* start the virtual machine with Vagrant
  ```
    vagrant up
  ```

### Usage:

The virtual machine should start and install Airflow.

You can see Airflow running at [localhost:14080](http://localhost:14080)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

Mesos can be accessed on [localhost:15050](http://localhost:15050)
