# Troubleshooting 'an application launched by Marathon does not start'

## Are all services up and running?

### Check that the mesos leader was elected

```
  service mesos-slave status
```

Check that there are no errors in the log, and that 'session establishment complete on server' appears in the logs.

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

Check that Docker was able to create the containers

```
  docker ps -a
```

If you see containers being killed then restarted, check the configuration. There might be some conflict on ports, or the application cannot start properly.

Another interesting test is looking at the logs of Docker service:

```
  journalctl -u docker -f
```

Sometimes, health-checks keep failing and that causes Marathon to keep the application in 'deploying' state.

## Did Marathon attempt to start the application?

If the application is a Docker container, then you can check the following:

### Was the Docker image downloaded?

Run inside the Vagrant VM

```
  docker images
```

Then check that the Docker image for your application is present.

Sometimes, Docker Hub is unreasonably slow. You may have more luck attempting to start the application a few minutes later,
or even run 'docker pull' yourself.

## Marathon did not even attempt to start the application

Check that the constraints that you have put on the application are possible. In particular, if you have a constraint on the hostname,
check that this hostname is known to Mesos (look in the Mesos console).

Ports exposed by the application are managed by Mesos. It controls in particular if the port is in acceptable ranges.
Those ranges are usually 4000-5000 and 31000-32000. Check the value of 'mesos_resources' variable for your environment.

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
