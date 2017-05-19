# Configuration for infrastructure

The infrastructure contains all the low-level components used to manage the installation of MIP on a Linux machine (Ubuntu or RedHat). It takes care of networking, process management, logging, security.

It also sets up and configures the [Mesos](https://mesos.apache.org) stack for clustering machines together and managing software services.

## ENV/etc/ansible/hosts

```ini

# Control node: one control node should be selected, not necessarily in the datacenter - it can be the local desktop -
# but it should satisfy the following requirements:
# - It has a direct network access to all services on the datacenter, in particular the databases and Marathon
# - We can install the required packages (docker-engine, docker-py, curl...) for proper function of the Ansible tasks
[control]
demo

# Infrastructure building block: define a 'infrastructure' group encompassing the configuration of the groups defined below
[infrastructure:children]
managed
zookeeper
mesos-leader
mesos-mixed
mesos-follower

# Managed hosts should contain all servers in the datacenter.
# Common software, configuration and security settings will be applied on them.
[managed]
demo
# demo fqdn="demo.mydomain.com"


# Install Zookeeper, required by Mesos
[zookeeper]
demo

# Install Mesos leader and Marathon
[mesos-leader]
# none

# Install the full Mesos stack, including Mesos master and agent, Docker and Marathon
[mesos-mixed]
demo

# Install Mesos agent and Docker
[mesos-follower]
# none

```

## Mandatory variables

None

## Optional variables

### ENV/etc/ansible/group_vars/all

```yaml

mesos_leader_hostname_override:
marathon_hostname_override:

```

### ENV/etc/ansible/group_vars/infrastructure

```yaml

do_hosts_cleanup: false
always_add_localhost: false

#apt_proxy_host:
apt_proxy_port: 3142
#apt_proxy_url:

mesos_cluster_override:

# authentication options for Mesos
zk_mesos_user:
zk_mesos_user_secret:

do_mesos_framework_auth: false
do_mesos_follower_auth: false
mesos_credentials: []
mesos_follower_secret: ""

# Additional configurations
mesos_additional_configs: []
  # For example:
  # - name: FOO
  #   value: bar

docker_listen_tcp: false
docker_options: []
docker_network_options: []

# If setup, the configuration for the proxy will be added to the managed systems
proxy_http: http://proxy.tld:8080
proxy_ftp: "{{ proxy_http }}"
proxy_https: "{{ proxy_http }}"

```
