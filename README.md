# CoreELEC as a Server

CoreELEC is a Linux system (JeOS - Just enough Operational System) that runs on devices with Amlogic processors. It has the minimum required to run the Kodi system and uses the original Amlogic Kernel for Android (4.9.113) having support for almost all embedded devices (Bluetooth, WiFi, Ethernet, Audio and Video Output, Hardware Video Decoding) using the original Android structure while other Linux distributions often do not support all installed devices.

Usually new software is installed through add-on using the GUI interface (Kodi), where the software is usually aimed for multimedia activities. One exception is the system-oriented software Docker, however it is limited to version 19.

Generally boxes sold with the Amlogic processors line have reasonably high memory for this type of system (4/8 GB) and multi-core processor with a very attractive price. The possibility of using it as a server is very resonable. 

This project provides a bash script to disable Kodi, install Entware (a package manager usually used on OpenWRT), software development tools (with headers) and Docker 20.10 ().


