# Troubleshooting the portal-backend deployment

If you encounter a timeout problem while deploying:
* Check the portal-backend logs either using the marathon UI or using `docker logs`.
  * If you notice a DNS problem (the portal database hostname cannot be resolved)
    You can update the DNS servers to use within the container by adding something
    like this to your envs/group_vars/infrastructure file:
    ```
    docker_options:
      - "--dns <DNS IP>"
    ```
* If the portal-backend logs look good but the backend take too much time to be deployed,
  you might have to allocate more resources for this component (hint: memory >= 1024 MB).
