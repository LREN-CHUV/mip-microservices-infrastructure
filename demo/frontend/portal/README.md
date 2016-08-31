## Portal demo

### Installation:

* install [Ansible](https://www.ansible.com/) version 2.1.0 or better. On Ubuntu you can use the script ./common/scripts/bootstrap.sh
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

### Usage:

The virtual machine should start and install the MIP portal.

The portal should be accessible from [localhost:18080](http://localhost:18080)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

### Testing

TODO: provide example data and some tests
