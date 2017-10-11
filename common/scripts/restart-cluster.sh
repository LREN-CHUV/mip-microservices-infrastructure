#!/bin/sh

sudo service marathon stop
sudo service mesos-slave stop
sudo service docker stop
sudo service mesos-master stop
sudo service zookeeper stop

sudo service zookeeper start
sudo service mesos-master start
sudo service docker start
sudo service mesos-slave start
sudo service marathon start
