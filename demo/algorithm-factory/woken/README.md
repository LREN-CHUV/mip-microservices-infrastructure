## Woken demo

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

### Troubleshooting: VirtualBox is complaining that the installation is incomplete

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

### Usage:

The virtual machine should start and install Woken.

Woken webservices are accessible from [localhost:14087](http://localhost:14087)

Marathon can be accessed on [localhost:15080](http://localhost:15080)

Chronos can be accessed on [localhost:14400](http://localhost:14400)

### Testing

Run the following tests using curl:

TODO: provide example data and some tests
