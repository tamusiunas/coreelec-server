# CoreELEC as a Linux Server

[CoreELEC](https://coreelec.org) is a Linux system (JeOS - Just enough Operational System) that runs on devices with Amlogic processors. It has the minimum required to run the Kodi system and uses the original Amlogic Kernel for Android (4.9.113) having support for almost all embedded devices (Bluetooth, WiFi, Ethernet, Audio and Video Output, Hardware Video Decoding) using the original Android structure while other Linux distributions often do not support all installed devices.

Usually new software is installed through add-on using the GUI interface (Kodi), where the software is usually aimed for multimedia activities. One exception is the system-oriented software Docker, however it is limited to version 19.

Generally boxes sold with the Amlogic processors line have reasonably high memory for this type of system (4/8 GB) and multi-core processor with a very attractive price. The possibility of using it as a server is very reasonable. 

This project provides a bash script to disable Kodi, install [Entware](https://github.com/Entware/Entware/wiki) (a package manager usually used by OpenWRT), software development tools (with headers) and [Docker 22.06](https://github.com/tamusiunas/docker-coreelec).

## Usage

- Enable ssh via Kodi / CoreELEC interface on the device
- Access the device via SSH

```bash
curl https://raw.githubusercontent.com/tamusiunas/coreelec-server/main/configure-coreelec-server.bash -o \
  /storage/configure-coreelec-server.bash
bash /storage/configure-coreelec-server.bash
```

## How to disable Kodi manually

```bash
systemctl stop kodi
systemctl disable kodi
systemctl mask kodi
```

## How to reenable Kodi

```bash
systemctl unmask kodi
systemctl enable kodi
systemctl start kodi
```

## Packages installed

Packages | Source
---------|-------
gcc, busybox, ldd, make, gawk, sed, python3-pip, patch, diffutils, coreutils-install, git | [Entware](https://github.com/Entware/Entware/wiki)
packages and Linux headers | [Entware](https://github.com/Entware/Entware/wiki)
Docker 22.06 | [docker-coreelec](https://github.com/tamusiunas/docker-coreelec)

## How to use opkg

```bash
opkg update # update packages list
opkg list # list available packages
opkg search <software> # search for a package
opkg upgrade # upgrade upgradeable packages
opkg remove <software> # remove package
opkg -help # help
```
