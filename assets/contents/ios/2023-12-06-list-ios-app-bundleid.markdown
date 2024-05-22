---
title: Iphone list installed app bundle ID using MacOS
layout: content
duration: 1mn
tags: ios
---

 
 To list installed apps and their bundle identifiers on an iPhone using the command line on a Mac, you can use the following steps:

1. Connect your iPhone to your Mac.

2. Open Terminal on your Mac.

3. Run the following command to list the installed apps and their bundle identifiers:

```bash
ideviceinstaller -l
```

If you don't have `ideviceinstaller` installed, you can install it using Homebrew. If you don't have Homebrew installed, you can install it by following the instructions on the Homebrew website: https://brew.sh/

Once Homebrew is installed, you can install `ideviceinstaller` by running the following commands:

```bash
brew tap homebrew/core
brew install ideviceinstaller
```

After installing `ideviceinstaller`, you can use the earlier command to list the installed apps and their bundle identifiers.

Please note that you might need to have the necessary dependencies installed, including libimobiledevice. You can install it using Homebrew as well:

```bash
brew install libimobiledevice
```

Keep in mind that Apple's security features may require you to trust the connected device on your iPhone before running these commands. Additionally, the command might require you to have developer tools or Xcode installed on your Mac.

Always be cautious when using command-line tools, and make sure to follow the necessary security precautions to protect your devices and data.