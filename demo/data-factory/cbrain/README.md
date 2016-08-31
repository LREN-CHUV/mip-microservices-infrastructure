## CBrain demo

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

The virtual machine should start and install CBrain, one data provider and one Bourreau.

You can see the CBrain portal running at [localhost:14580](http://localhost:14580)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

The first time CBrain starts, it generates an administrator password. You need to find it in the logs of the portal application.
You can download the stdout file from Marathon by navigating to the CBrain > portal application, then you can look for the password in the log.

Another solution is to log into the virtual machine with `vagrant ssh` then locate the Docker container running the CBrain portal with `docker ps` and finally to access the logs of that container using `docker logs`

### Testing

TODO: provide example data and some tests
