
# Troubleshooting database migrations

## Migrations using Flyway

* Check that the migration worked without problems

```
  docker inspect setup_woken_db | grep Status
  # it should return:
  #   "Status": "exited",
  docker inspect setup_woken_db | grep ExitCode
  # it should return:
  #   "ExitCode": 0,
```

Note: replace setup_woken_db by the name of the Docker container that should manage the migration for your database.
Currently, the name should be one of setup_woken_db, migrate_ldsm, migrate_meta_db

* Check that the migration did what you expected

```
  docker logs setup_woken_db
  # it should return for example:
  # Migrating schema "public" to version 1.0 - Create-result-table
```

* Enter the Docker container running the Postgres database

```
  # List the running Docker containers
  docker ps
  # Select the id of the container runing Postgres
  docker exec -it <id of container> /bin/bash
```

* Connect to Postgres database as user 'postgres'

```
  psql -U postgres
```

* Type \\d to list the tables. There should be a 'schema_version' table and one or more tables.
