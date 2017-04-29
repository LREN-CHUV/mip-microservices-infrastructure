TODO

* mesos, other essential services: automatically restart service
  https://blog.codeship.com/running-node-js-linux-systemd/
* watchtower role, to launch with Marathon
* jenkins, dockerized, launch with Marathon
* keep track of version for Docker in local facts
* connect Chronos to Sentry (raven_dsn option)
* connect Chronos to Graphite

* DNSMasq, to use to allow Docker containers to access other machines
* overlay and custom DNS configuration for Docker
* put back the setup for demo database for woken features

LATER

* [stack simplification] Replace Zookeeper with Consul. Depends on [MESOS-3797](https://issues.apache.org/jira/browse/MESOS-3797)
* Use Mesos maintenance mode to perform system upgrades, clean logs, rollout of new software. See [Mesos maintenance](http://mesos.apache.org/documentation/latest/maintenance/)
* better manage upgrades between major versions of Postgres: https://hub.docker.com/r/tianon/postgres-upgrade/
* [security] Integrate CoreOs Clair static analyser for Docker images to assess vulnerabilities in our images
 https://github.com/coreos/clair

https://galaxy.ansible.com/ANXS/apt/
https://github.com/knopki/ansible-locale
https://github.com/Stouts/Stouts.locale

https://github.com/Stouts/Stouts.notify
  Could be used to send notifications to Slack

Alternatives:
https://github.com/Stouts/Stouts.apt

Security:
https://github.com/Stouts/Stouts.openssh
https://github.com/zenzire/ansible-bootstrap-ubuntu
https://github.com/Stouts/Stouts.postfix
https://github.com/Stouts/Stouts.openvpn
