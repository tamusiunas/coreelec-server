#!/bin/bash

#
# Configure CoreELEC as server
#

#
# Check if it's already configured
#
if [ -f "/storage/.coreelec-server-installed" ]; then
  echo ""
  echo "corelec-server is already configured"
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
/opt/bin/opkg update
/opt/bin/opkg install gcc busybox ldd make gawk sed python3-pip patch diffutils coreutils-install git tar file
#
# Install headers
#
mkdir -p /opt/include
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
curl https://raw.githubusercontent.com/tamusiunas/coreelec-server/main/system.d/kill-splash-screen.service -o /storage/.config/system.d/kill-splash-screen.service
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
# Increase vm.max_map_count
#
echo "vm.max_map_count=262144" > /storage/.config/sysctl.d/vm.conf

#
# Create /storage/.coreelec-server-installed to know that coreelec is installed
#
touch /storage/.coreelec-server-installed

#
# Install Docker
#
curl https://raw.githubusercontent.com/tamusiunas/docker-coreelec/main/auto-install-docker-coreelec.bash -o /storage/auto-install-docker-coreelec.bash
bash /storage/auto-install-docker-coreelec.bash noshutdown
rm /storage/auto-install-docker-coreelec.bash
echo ""
echo "To complete the configuration reboot your box"
echo ""



#
# It's installed
#
