# Configure docker for running container with your user instead of root

* Open `/etc/docker/daemon.json` and put insite it:

```txt
{
		"userns-remap": "spydemon:spydemon"
}
```

* Don't forget to add a mapping for your user in `/etc/subgid` and `/etc/subuid` files.
