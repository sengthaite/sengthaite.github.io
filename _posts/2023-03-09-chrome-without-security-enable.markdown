---
title: Open Chrome in Mac with security disabled for testing
layout: content
duration: 1mn
tags: general
---

# Open Chrome with Security Disabled for testing in Mac

1. Search for **Terminal** application with spotlight *command + space*, then search and open the application

2. Open the Chrome app
```sh
open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security
```