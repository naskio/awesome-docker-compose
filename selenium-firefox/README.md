# Selenium - Standalone Firefox

Use this image to run Firefox in a standalone mode. You can use this to run Selenium tests in a headless mode.

> default port: 4444

## Usage

```python
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

driver = webdriver.Remote("http://selenium-firefox:4444/wd/hub", DesiredCapabilities.FIREFOX)
```