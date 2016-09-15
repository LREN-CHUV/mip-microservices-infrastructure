# Troubleshooting 'an application launched by Marathon does not start'

## Are all services up and running?

### On the master node, check that all services are running:

```
  service zookeeper status
  service mesos-master status
  service marathon status
```

Check the service logs:

```
  journalctl -u mesos-master
```
ZOO_INFO@check_events@1775: session establishment complete on server [192.168.34.67:2181],  sessionId=0x156ea041e660000, negotiated timeout=10000
ZOO_WARN@zookeeper_interest@1570: Exceeded deadline by 16ms

```
  journalctl -u marathon
```


If port mapping is used, check that the host ports required are in the range managed by Mesos, usually [4000,5000[ and [30000,31000[

### Check that the mesos leader was elected

TODO

## Did Marathon attempt to start the application?

If the application is a Docker container, then you can check the following:

### Was the Docker image downloaded?

Run inside the Vagrant VM

```
  docker images
```

Then check that the Docker image for your application is present.

## Marathon did not even attempt to start the application

TODO

## In a Vagrant VM

I have not managed to setup a proper DNS server inside a Vagrant VM that can be used from the Docker containers to resolve the hostname of the Vagrant VM and its companion VMs.

If your container needs to resolve any DNs name, then it needs a little help.

For example, in the demo for woken, we add:

```
woken_docker_parameters:
  - key: 'add-host'
    value: "woken:192.168.21.66"
  - key: 'add-host'
    value: "woken.local:192.168.21.66"
```
