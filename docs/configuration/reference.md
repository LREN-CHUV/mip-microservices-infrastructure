# Configuration for Reference

The Reference sets up databases containing reference data.

## ENV/etc/ansible/hosts

```ini

# Reference building block: define a 'reference' group encompassing the configuration of the groups defined below
[reference:children]
research-db
meta-db

# Install research-database
[research-db]
demo

# Install meta-database
[meta-db]
demo

```

## Mandatory variables

None

## Optional variables

### ENV/etc/ansible/group_vars/reference

```

# Deploy research-db as an independent database. If false, then we assume that there is
# a database already running and we add to it a new 'ldsm' schema
research_db_deploy: yes

# Hint in Marathon listing all the databases running in this Postgres server,
# used when research_db_deploy is true
research_db_databases: "{{ research_db_name }}"

# Force cleanup of the Research DB. Please never use that in production!
research_db_cleanup: false

research_db_cpus: 0.5
research_db_mem: 128.0

# Deploy meta-db as an independent database. If false, then we assume that there is
# a database already running and we add to it a new 'meta' schema
meta_db_deploy: no

# when meta_db_deploy is true
meta_db_cpus: 0.5
meta_db_mem: 128.0

# Force cleanup of the Meta DB. Please never use that in production!
meta_db_cleanup: false

```
