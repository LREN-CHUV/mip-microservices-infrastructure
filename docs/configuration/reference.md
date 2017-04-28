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
# It must be on the same host as research-db if meta-db is installed as a companion base collocated with research-db
[meta-db]
demo

```

## Mandatory variables

### ENV/etc/ansible/group_vars/all

```

research_db_companion_bases:
  - 'meta-db'
  - 'woken-db'

```

## Optional variables

### ENV/etc/ansible/group_vars/reference

```

# Deploy research-db as an independent database. If false, then we assume that there is
# a database already running and we add to it a new 'research' schema
research_db_deploy: yes

# Force cleanup of the Research DB. Please never use that in production!
research_db_cleanup: false

research_db_cpus: 0.5
research_db_mem: 128.0

# when meta-db is deployed as an independent database
meta_db_cpus: 0.5
meta_db_mem: 128.0

# Force cleanup of the Meta DB. Please never use that in production!
meta_db_cleanup: false

```
