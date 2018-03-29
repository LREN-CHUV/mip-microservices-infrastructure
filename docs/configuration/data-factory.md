# Configuration for Data Factory

The Data Factory provides the workflow engine to continuously execute image pre-processing and transformation of EHR data.

This building block may require the installation of Matlab to be able to execute MRI image pre-processing using SPM.

## ENV/etc/ansible/hosts

```ini

# Data Factory building block: define an 'data-factory' group encompassing the configuration of the groups defined below
[data-factory:children]
airflow-master
airflow-agent
df-bases

# Install Airflow master (databases + webserver)
[airflow-master]
demo

# Install Airflow agent (scheduler + scripts + related applications like SPM)
[airflow-agent]
demo

# Install the databases for Data Factory
[df-bases]
demo

```

## Mandatory variables

### ENV/etc/ansible/group_vars/all

```

airflow_web_base_url: "http://demo:14080"

airflow_db_companion_bases:
  - data-catalog-db
  - i2b2-capture-db
  - i2b2-mip-db
  - mipmap-db

# or add airflow-db and all the bases above to research_db_companion_bases,
# and use this setting:
#
# airflow_db_companion_bases: []
#

```

### ENV/etc/ansible/group_vars/data-factory

```

data_factory_user: 'airflow'
data_factory_user_id: 1011
data_factory_group: 'airflow'
data_factory_group_id: 1011

airflow_pool_io_intensive: 12
airflow_pool_remote_file_copy: 2
airflow_pool_image_preprocessing: '{{ ansible_processor_vcpus - airflow_pool_io_intensive - 1 }}'

```

### ENV/etc/ansible/host_vars/[control node] (crypted)

```

```

### ENV/etc/ansible/host_vars/[woken-db host] (crypted)

```


```

## Optional variables

### ENV/etc/ansible/group_vars/data-factory

```

airflow_scheduler_cpus: 0.2
airflow_scheduler_mem: 2560.0

airflow_webserver_cpus: 0.2
airflow_webserver_mem: 512.0

main_dataset_id: "demo"
main_dataset_label: "Demo"

```
