#!/bin/sh

#
# Provides a fix to a Vagrant installation with the following error message:
#
# VirtualBox is complaining that the installation is incomplete. Please
# run `VBoxManage --version` to see the error message which should contain
# instructions on how to fix this error.
#

sudo apt-get install --reinstall virtualbox-dkms linux-headers-generic
