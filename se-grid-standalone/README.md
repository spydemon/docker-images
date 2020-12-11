# Se-grid-standalone container

Main aim of this container is to be compatible with [Magento MFTF](https://devdocs.magento.com/mftf/docs/introduction.html) system and Laravel Dusk.

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

# Debugging

If your tests won't run, you can find some logging information with the following commands:

```sh
# Stop the deamon and launch selenium process on the front-ground. This will allow you to see stdout and stderr:
/etc/init.d/selenium stop
java -jar /opt/selenium.jar -role standalone

# If it's not enough, you can also enable chromedriver log with those options:
java -Dwebdriver.chrome.logfile='/var/log/chromedriver.log' -Dwebdriver.chrome.verboseLogging=true -jar /opt/selenium.jar -role standalone
```

## Common mistakes

### Missing `--no-sandbox` option

By default, the chromedriver refuses to start if we launch it with the `root` user. Unfortunately, `root` is the only existing one in my containers… The solution is to explicitly set the `--no-sandbox` flag when we start the process.
This should be done when we set the abilities of the driver.

#### How to set the `--no-sandbox` on Magento

In: `dev/tests/acceptance/tests/functional.suite.yml`, add:

```yaml
modules:
    […]
    config:
        \Magento\FunctionalTestingFramework\Module\MagentoWebDriver:
            […]
            capabilities:
                […]
                chromeOptions:
                    args: [ […], '--no-sandbox']
```

#### How to set the `--no-sandbox` flag on Laravel

In: `tests/DuskTestCase.php`, add:

```php
protected function driver()
{
    $options = (new ChromeOptions)->addArguments([
        […],
        '--no-sandbox',
    ]);
    return RemoteWebDriver::create(
        'http://base-se_grid:4444/wd/hub',
        DesiredCapabilities::chrome()->setCapability(
            ChromeOptions::CAPABILITY, $options
        )
    );
}
```