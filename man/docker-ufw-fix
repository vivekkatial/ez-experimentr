# Fixing Docker/NGINX issue

There is a known issue between using UFW on Linux-Ubuntu and Docker together. Here is how we can fix it.

1. First create a `daemon.json` file in `/etc/docker/` using the following command:

```
sudo touch /etc/docker/daemon.json
```

2. Once completed, add the following content in this file:

```
{
	"iptables": false
}
```

3. Confirm content is there:
```
cat /etc/docker/daemon.json
```

3. Restart docker:
```
sudo systemctl restart docker
```
