# Selenium - Standalone Chrome

Use this image to run Chrome in a standalone mode. You can use this to run Selenium tests in a headless mode.

> default port: 4444

## Usage

```python
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

driver = webdriver.Remote("http://selenium-chrome:4444/wd/hub", DesiredCapabilities.CHROME)
```