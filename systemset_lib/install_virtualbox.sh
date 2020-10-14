#!/bin/bash

echo "

Installing Virtualbox...

"

vb_package="virtualbox-6.0"
ep_url="https://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack"
main_distro="$(cat < /etc/apt/sources.list | grep ^deb | awk '{print $3}' | head -1)"

# Install repositories and update
if ! grep -R "download.virtualbox.org" /etc/apt/ &> /dev/null; then
	echo "deb http://download.virtualbox.org/virtualbox/debian $main_distro contrib" > /etc/apt/sources.list.d/virtualbox.list
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
	apt-get update
fi

# Install packages
apt-get install -y linux-headers-"$(uname -r)" "$vb_package" || echo -e "\nInstallation of Virtualbox did not work...\n"exit 1

# Get Extension Pack
if ! command -v vboxmanage &> /dev/null; then
  echo "VirtualBox is not installed"
  exit 1
fi

t=$(mktemp -d)
wget -P "$t" "$ep_url" && yes | vboxmanage extpack install --replace "$t"/*extpack && rm -rf "$t"

exit 0
