# Configuration for Hospital database

The Hospital database is deployed in the research network of hospitals. It should not have access or use identifying patient information. It works only with research-grade, depersonalised data.

The Hospital Database building block contains the following software components:

* PostgresRAW (ldsm-db): A Postgres database with the RAW plugin used to read on the fly data from CSV files, infer their schema and query the data without importing it into the database. PostgresRAW is used to perform queries on the features stored in the CSV files provided by the Data Factory.
* PostgresRAW-UI: Administrative interface to PostgresRAW, provides a web interface for interactive queries and dashboards.
* Exareme: A distributed and virtual database with analytics capabilities.
* WebMIPMap

### ENV/etc/ansible/group_vars/all

```

# Setup the standard research datasets into ldsm-db (when features_from = 'ldsm-db').
setup_standard_research_datasets: yes

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
