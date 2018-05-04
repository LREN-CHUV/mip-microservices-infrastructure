#!/bin/sh

sudo systemctl status docker
sudo systemctl status marathon
sudo systemctl status mesos-slave
sudo systemctl status mesos-master
sudo systemctl status zookeeper

sudo service marathon stop
sudo service mesos-slave stop
sudo service docker stop
sudo service mesos-master stop

/usr/share/zookeeper/bin/zkCli.sh
rmr /mesos
rmr /chronos
rmr /marathon
quit

sudo service zookeeper stop

sudo service zookeeper start
sudo service mesos-master start
sudo service docker start
sudo service mesos-slave start
sudo service marathon start
