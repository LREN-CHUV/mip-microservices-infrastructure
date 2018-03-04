# Configuration for Algorithm Factory

The Algorithm Factory provides the runtime to execute algorithms encapsulated in Docker containers.

Data for the analytics or machine learning algorithms is taken either from the Hospital database (PostgresRAW) or from the woken database.

## ENV/etc/ansible/hosts

```ini

# Algorithm Factory building block: define an 'algorithm-factory' group encompassing the configuration of the groups defined below
[algorithm-factory:children]
woken-db
woken
woken-validation

# Install woken-database
[woken-db]
demo

# Install woken
[woken]
demo

# Install woken-validation
[woken-validation]
demo

```

## Mandatory variables

### ENV/etc/ansible/group_vars/all

```

# Select where data features are coming from: ldms-db or research-db
features_from: 'ldsm-db'
# Use mip_cde_features to see only research data, otherwise use mip_local_features
features_table: 'mip_local_features'

```

### ENV/etc/ansible/host_vars/[control node] (crypted)

```

# Required when woken-db is deployed as an independent database
woken_db_admin_password:

```

### ENV/etc/ansible/host_vars/[woken-db host] (crypted)

```

woken_db_password:
# Required when woken-db is deployed as an independent database
woken_db_admin_password:

```

## Optional variables

### ENV/etc/ansible/group_vars/algorithm-factory

```

# Deploy woken-db as an independent database. If false, then we assume that there is
# a database already running and we add to it a new 'woken' schema
woken_db_deploy: yes

# Hint in Marathon listing all the databases running in this Postgres server,
# used when woken_db_deploy is true
woken_db_databases: "{{ woken_db_name }}"

# Force cleanup of the Woken DB. Please never use that in production!
woken_db_cleanup: false

woken_db_cpus: 0.5
woken_db_mem: 128.0

chronos_cpus: 0.5
chronos_mem: 512.0

# Amount of CPU reserved for woken
woken_cpus: 0.5
# Amount of memory in mb reserved for woken
woken_mem: 1024.0

# Amount of CPU reserved for woken validation
woken_validation_cpus: 0.5
# Amount of memory in mb reserved for woken validation
woken_validation_mem: 1024.0

woken_docker_bridge_network: 'bridge'

```
