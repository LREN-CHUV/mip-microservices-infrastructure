# Trooubleshooting Woken

```
  docker logs $(docker ps -qf "label=org.label-schema.name=hbpmip/woken" | head -n1)
```
