

https://www.digitalocean.com/community/tutorials/how-to-configure-the-linux-firewall-for-docker-swarm-on-ubuntu-16-04


```
  apt install firewalld
```

Verify that it's running:

```
  systemctl status firewalld
```

If it's not running, start it:

```
    systemctl start firewalld
```

Then enable it so that it starts on boot:

```
    systemctl enable firewalld
```

    firewall-cmd --add-service=ssh --zone=public --permanent
    firewall-cmd --add-service=http --zone=public --permanent
    firewall-cmd --add-service=https --zone=public --permanent
    firewall-cmd --add-source=172.16.0.0/12 --zone=trusted --permanent

Note: If you make a mistake and need to remove an entry, type:
firewall-cmd --remove-port=port-number/tcp —permanent.

Afterwards, reload the firewall:

```
    firewall-cmd --reload
```

Then restart Docker.

```
    systemctl restart docker
```
