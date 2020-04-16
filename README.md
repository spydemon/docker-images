# Tricks
## Configure docker for running container with your user instead of root

* Open `/etc/docker/daemon.json` and put insite it:

```txt
{
		"userns-remap": "spydemon:spydemon"
}
```

* Don't forget to add a mapping for your user in `/etc/subgid` and `/etc/subuid` files.

## Use the `toolbox/dc.sh` script for handling your projects

* Open your shell setting file (eg: `.bashrc`, `.zschrc`) and add the following alias:

```shell script
alias dc='<repository_root_path>/toolbox/dc.sh'
```

Now, you can use the more convenient `dc` command for managing your projects!

```text
> dc help
/<repository_root_path>/toolbox/dc.sh usage:
 restart: restart the project
 start:   start the project
 stop:    stop the project

Note: don't forget to go to your docker-compose project folder before running the command.
```

# Technical memo
## How to rebuild images

* Compile the new image: `docker build --tag spydemon/php56-magento1:0.1 .`.
* Push the new image: `docker push spydemon/php56-magento1:0.1`.
