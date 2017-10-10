# Configuration for Hospital database

The Hospital database is deployed in the research network of hospitals. It should not have access or use identifying patient information. It works only with research-grade, depersonalised data.

The Hospital Database building block contains the following software components:

* PostgresRAW (ldsm-db): A Postgres database with the RAW plugin used to read on the fly data from CSV files, infer their schema and query the data without importing it into the database. PostgresRAW is used to perform queries on the features stored in the CSV files provided by the Data Factory.
* PostgresRAW-UI: Administrative interface to PostgresRAW, provides a web interface for interactive queries and dashboards.
* Exareme: A distributed and virtual database with analytics capabilities.
* WebMIPMap

## ENV/etc/ansible/hosts

```ini

# Hospital database building block: define a 'hospital-database' group encompassing the configuration of the groups defined below
[hospital-database:children]
ldsm-db
postgresraw-ui

# Install PostgresRAW
[ldsm-db]
demo

# Install PostgresRAW-UI
[postgresraw-ui]
demo

```

## Mandatory variables

### ENV/etc/ansible/group_vars/all

```

# Setup the standard research datasets into ldsm-db. Other options: 'research-db' or 'none'
setup_standard_research_datasets: 'ldsm-db'

```

### ENV/etc/ansible/host_vars/[control node] (crypted)

```

# Required when ldsm-db is deployed as an independent database
ldsm_db_admin_password:

```

### ENV/etc/ansible/host_vars/[ldsm-db host] (crypted)

```

ldsm_db_password:
# Required when ldsm-db is deployed as an independent database
ldsm_db_admin_password:

```

## Optional variables

### ENV/etc/ansible/group_vars/hospital-database

```

ldsm_db_raw_data_dir_override:

ldsm_db_cpus: 0.2
ldsm_db_mem: 128.0

# Force cleanup of the LDSM database. Please never use that in production!
ldsm_db_cleanup: false

# Amount of CPU reserved for PostgresRAW UI
postgresraw_ui_cpus: 0.2
# Amount of memory in mb reserved for PostgresRAW UI
postgresraw_ui_mem: 100.0

```
