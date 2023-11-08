---
title: SSH to Termux Android via USB Guide
layout: content
duration: 2mn
tags: termux
---

# Prerequisite

* **Android device** with [**Termux**](https://f-droid.org/en/packages/com.termux/) installed
* **OpenSSH** package installed both in termux and your PC
* **Android Platform Tools** installed on your PC
* Both devices connect to the same wifi
* USB cable connect between the android and the PC


# Installation

### **1. Termux Android**

```sh
apt update
apt install openssh
passwd # for first copy id_rsa from PC to termux
sshd # run the openssh daemon
```
> **Reference**: [Remote Access Termux](https://wiki.termux.com/wiki/Remote_Access) 

### **2. Local PC**

> Install openssh-client and openssh-server and generate ssh key if not exist.

```sh
# check if ssh key exist in $HOME/.ssh with filename "id_rsa" and "id_rsa.pub"
ls $HOME/.ssh
```

> If the file not found generate one
```sh
ssh-keygen -t rsa -b 2048 -f id_rsa
```
> More about ssh : [ssh](https://man7.org/linux/man-pages/man1/ssh.1.html)

> Else if the ssh key exist
```sh
ssh-copy-id -p 8022 -i id_rsa IP_ADDRESS_ANDROID
# This will prompt to input password set via passwd in termux
```
> Find local ip of android
```sh
# Open the termux application, then
ifconfig | grep 192.168
# There should be the result ip display
```

> After copied successfully, connect your android to PC, enable developer mode and usb debugging mode. [How?](https://developer.android.com/studio/debug/dev-options)

> Then install adb via android-sdk-platform tools [Where?](https://developer.android.com/studio/releases/platform-tools). Or via package manager e.g. in debian 

```sh
sudo apt update
# search for the package in cache
sudo apt-cache search android-sdk # expect many results
sudo apt install android-sdk-platform-tools
```

> If installed successfully, try

```sh
adb help # will show command options
adb devices # look into android and allow the request, after allow type in this command will show the list of devices
```

> For this guide, recommend to connect only one android device to the PC for simplicity when [portfowarding](https://en.wikipedia.org/wiki/Port_forwarding) via adb.

> Then portforwarding with tcp:8022, 8022 is default port for ssh in termux

```sh
adb forward tcp:8022 tcp:8022
```

> Try to ssh to the only connected android device via usb

```sh
ssh localhost -p 8022 # should show termux terminal in the PC
```