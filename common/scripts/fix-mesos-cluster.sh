#!/bin/sh

# Use those commands if Chronos doesn't restart after an upgrade

service chronos stop 
service marathon stop
service mesos-slave stop
docker rm docker-registry
service docker stop
service mesos-master stop
service zookeeper stop

rm -f /tmp/mesos/meta/slaves/latest
rm -f /var/log/mesos/*

# Brute force
rm -rf /tmp/mesos/ /var/run/mesos/ /var/mesos

# Extreme cases: reset zookeeper
#rm -rf /var/lib/zookeeper/*

service zookeeper start
service mesos-master start
sleep 5
service docker start
service mesos-slave start
sleep 5
service marathon start
service chronos start
