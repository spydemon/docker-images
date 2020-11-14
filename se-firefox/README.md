#Se-firefox container

It contains a Gekodriver and a Firefox browser that can be used by Selenium webdriver.

## How to configure it?
Example of use in a docker-compose project:

```yaml
version: '2.1'

services:
    […]
    se_firefox:
        container_name: base-se_firefox
        extra_hosts:
             - "magento24.local:172.17.0.1"
        hostname: base-se_firefox
        image: spydemon/se-firefox:0.1
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

## How to use it ?

It could be reached through a usual driver creation:

```php
    protected function getDriver() : RemoteWebDriver
    {
        if (is_null($this->driver)) {
            $desiredCapabilities = DesiredCapabilities::firefox();
            $desiredCapabilities->setCapability('acceptSslCerts', false);
            $this->driver = RemoteWebDriver::create(
                'http://base-se_firefox:4444/',
                $desiredCapabilities,
                60000,
                60000
            );
            $this->driver->manage()->window()->maximize();
        }
        return $this->driver;
    }
```