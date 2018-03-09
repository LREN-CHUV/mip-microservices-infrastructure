# Configuration for Web Analytics

The Web Analytics contains the web portal and its backend used to access the functionality of the MIP.

## ENV/etc/ansible/hosts

```ini

# Web Analytics building block: define an 'web-analytics' group encompassing the configuration of the groups defined below
[web-analytics:children]
portal-db
portal-backend
portal-frontend

# Install portal-database
[portal-db]
demo

# Install portal-backend
[portal-backend]
demo

# Install portal-frontend
[portal-frontend]
demo

```

## Mandatory variables

### ENV/etc/ansible/group_vars/all

```

# Select where data features are coming from: ldms-db or research-db
features_from: 'ldsm-db'
# Use mip_cde_features to see only research data, otherwise use mip_local_features
features_table: 'mip_local_features'

# Enable user login with HBP OpenID service
portal_backend_security_enabled: true

# The port for Portal frontend. You can use port 80, or use a port in the range 4000-5000 or 31000-32000
# if the Portal frontend is located behind a web proxy
portal_frontend_port: 80

# The base URL used for redirection. Required to redirect the user to the correct location, when the site address is changed by a proxy for example.
portal_frontend_base_url: "http://{{ portal_frontend_virtual_host }}:{{ portal_frontend_port }}"

# Either "local" or "federation", default to "local"
portal_frontend_mode: 'local'

# Name of the instance deployed
portal_frontend_instance_name: 'MIP for my hospital'

# The list of datasets
# TODO: this configuration is redundant and should come from Woken
portal_backend_datasets: chuv,brescia,lille

```

### ENV/etc/ansible/host_vars/[control node] (crypted)

```

# Required when portal-db is deployed as an independent database
portal_db_admin_password:

# Required when portal_backend_security_enabled is true
portal_backend_hbp_client_id:
portal_backend_hbp_client_secret:

```

### ENV/etc/ansible/host_vars/[portal-db host] (crypted)

```

portal_db_password:
# Required when portal-db is deployed as an independent database
portal_db_admin_password:

```

### ENV/etc/ansible/host_vars/[portal-frontend host] (crypted)

```

# Required when Google Analytics is used
portal_frontend_tracker_id: 'UA-FILL-ME'

```

## Optional variables

### ENV/etc/ansible/group_vars/web-analytics

```

# Force cleanup of the Woken DB. Please never use that in production!
portal_db_cleanup: false

# When portal-db is deployed as an independent database
portal_db_cpus: 0.5
portal_db_mem: 128.0

# Amount of CPU reserved for Portal backend
portal_backend_cpus: 0.5
# Amount of memory in mb reserved for Portal backend
portal_backend_mem: 1024.0

# Number of instances of Portal backend to launch
portal_backend_instances: 1

portal_backend_session_timeout: 2592000
portal_backend_logging_level_web: "DEBUG"
portal_backend_logging_level_hibernate: "DEBUG"
portal_backend_frontend_after_login_url: 'http://{{ portal_backend_marathon_host }}:{{ portal_backend_port }}/home'

portal_backend_security_enabled: false

# Amount of CPU reserved for Portal frontend
portal_frontend_cpus: 1.0
# Amount of memory in mb reserved for Portal frontend
portal_frontend_mem: 10.0

# Enable Google Analytics
portal_frontend_google_analytics: false

```
