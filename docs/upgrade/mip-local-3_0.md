
# Upgrade from MIP 2.x to MIP 3.0

## Update code for local installation scripts

Update the code in the local infrastructure project to MIP 3.0 by merging its contents with the latest version from shared mip-microservice-infrastructure project.

```
  git remote add mmsi https://github.com/HBPMedical/mip-microservices-infrastructure.git
  git fetch mmsi master
  git fetch --tags mmsi master
  git merge 3.0.1
  # Deal with merge issues
  rm -rf roles/letsencrypt/ roles/maven/
  ./after-update.sh
  git commit
```

## Update the configuration for MIP 3.0

Add to envs/mip-local/etc/ansible/group_vars/algorithm-factory:

```
woken_node_name: "<Name of the node in the Federation>"
woken_default_job_mem: 4096

woken_tables:
  - name: mip_cde_features
    primaryKey:
      - name: "subjectcode"
        sqlType: "varchar"
    datasetColumn:
      name: "dataset"
      sqlType: "varchar"
  - name: mip_local_features
    primaryKey:
      - name: "subjectcode"
        sqlType: "varchar"
    datasetColumn:
      name: "dataset"
      sqlType: "varchar"

```

Add to envs/mip-local/etc/ansible/group_vars/all:

```
release_stage: 'production'
```
