#!/bin/bash

#
# Configure CoreELEC as server
#

#
# Check if it's already installed
#
if [ -f "/storage/.coreelec-server-installed" ]; then
  echo ""
  echo "corelec-server is already installed"
  echo ""
  exit 1
fi

#
# Install Entware
#
echo ""
echo "Installing Entware"
echo ""
echo "n" | /usr/sbin/installentware 
opkg install gcc busybox ldd make gawk sed python3-pip patch diffutils coreutils-install git tar file
#
# Install headers
#
arch_uname=$(uname -m)
if [ -z "${arch_uname##*aarch64*}" ]; then
  wget -qO- http://bin.entware.net/aarch64-k3.10/include/include.tar.gz | tar xvz -C /opt/include
elif [ -z "${arch_uname##*hf*}" ]; then
  wget -qO- http://bin.entware.net/armv7sf-k3.2/include/include.tar.gz | tar xvz -C /opt/include
elif [ -z "${arch_uname##*v7*}" ]; then
  wget -qO- http://bin.entware.net/armv7sf-k3.2/include/include.tar.gz | tar xvz -C /opt/include
elif [ -z "${arch_uname##*v6*}" ]; then
  wget -qO- http://bin.entware.net/armv5sf-k3.2/include/include.tar.gz | tar xvz -C /opt/include
fi

path_found=$(grep "/opt/bin/gcc_env.sh" /storage/.profile 2>/dev/null)
if [ "$path_found" == "" ]; then
  echo "source /opt/bin/gcc_env.sh" >> /storage/.profile
fi

#
# Install system.d scripts
#
echo ""
echo "Installing system.d scripts"
echo ""
# Kill splash-screen program
curl https://raw.githubusercontent.com/fabriciotamusiunas/coreelec-server/main/system.d/kill-splash-screen.service -o /storage/.config/system.d/kill-splash-screen.service
systemctl daemon-reload
systemctl enable kill-splash-screen.service

#
# Disable Kodi
#
echo ""
echo "Disabling kodi"
echo "To enable it again type \"systemctl unmask kodi ; systemctl enable kodi ; systemctl start kodi\""
echo ""
systemctl stop kodi
systemctl disable kodi
systemctl mask kodi

#
# Install Docker
#
curl https://raw.githubusercontent.com/fabriciotamusiunas/docker-coreelec/main/auto-install-docker-coreelec.bash -o /storage/auto-install-docker-coreelec.bash
bash /storage/auto-install-docker-coreelec.bash
rm /storage/auto-install-docker-coreelec.bash

#
# It's installed
#
/storage/.coreelec-server-installed
