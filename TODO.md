TODO

* launch Gitlab with Marathon
* watchtower role, to launch with Marathon
* denodo: setup, upgrade, licenses
* jenkins, dockerized, launch with Marathon
* http://blog.romkevandermeulen.nl/2015/02/19/docker-gen-automatic-nginx-config-with-a-human-touch/
* keep track of version for Docker in local facts
* ensure that Docker-registry is up and running before deploying workflow app with Marathon
* connect Chronos to Sentry (raven_dsn option)
* connect Chronos to Graphite

LATER

* [stack simplification] Replace Zookeeper with Consul. Depends on [MESOS-3797](https://issues.apache.org/jira/browse/MESOS-3797)
* Use Mesos maintenance mode to perform system upgrades, clean logs, rollout of new software. See [Mesos maintenance](http://mesos.apache.org/documentation/latest/maintenance/)
* better manage upgrades between major versions of Postgres: https://hub.docker.com/r/tianon/postgres-upgrade/
* [security] Integrate CoreOs Clair static analyser for Docker images to assess vulnerabilities in our images
 https://github.com/coreos/clair
