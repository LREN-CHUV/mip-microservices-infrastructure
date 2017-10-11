# Troubleshooting Vagrant

## Accessing the Virtual machine

Virtual machines built with Vagrant are actually easy to access: run

```sh
  vagrant ssh
```

and you're in!. You can use sudo with no password to gain root access.

## VirtualBox is complaining that the installation is incomplete

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

```sh
  sudo apt-get install --reinstall virtualbox-dkms linux-headers-generic
```

or

```sh
  ./common/scripts/fix-vagrant.sh
```
