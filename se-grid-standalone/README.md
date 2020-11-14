# Se-grid-standalone container

Main aim of this container is to be compatible with [Magento MFTF](https://devdocs.magento.com/mftf/docs/introduction.html) system.

It runs a Selenum Grid server on its port 4444.

## How to configure it?
Example of use in a docker-compose project:

```yaml
version: '2.1'

services:
    […]
    se_grid:
        container_name: base-se_grid
        extra_hosts:
             - "magento24.local:172.17.0.1"
        hostname: base-se_grid
        image: spydemon/se-grid-standalone:0.1
        networks:
            - base
        ports:
            - "6901:5900"
```

### Regarding the `extra_hosts` directive

The container should be able to resolve all domain names that will be used during the test. Indeed, the Firefox browser will have to fetch the website content. Unfortunately, I didn't find a better solution for the moment.

The target IP can be the one used by the host since its 80 and 442 port should be redirected to a proxy that will handle the routing to the correct container.

### Regarding the port 5900

A VNC server runs on the port 5900 of the container that can be bound on the host (on port 6901 on this example). You can thus use a VNC client like Vinagre to connect on the X11 server of the container and be able to watch the execution of the test.

## How to use it with Magento?

This is an example of a `des/tests/acceptance/.env` Magento file that works with this server:

```shell script
[…]
SELENIUM_CLOSE_ALL_SESSIONS=true
SELENIUM_HOST=base-se_grid
SELENIUM_PORT=4444
SELENIUM_PROTOCOL=http
SELENIUM_PATH=/wd/hub
BROWSER=chrome
[…]
```

You can test the configuration by running the `php vendor/bin/mftf doctor` command in your Magento container.