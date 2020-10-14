#!/bin/bash

echo "

Installing Conky...

"

sudo add-apt-repository ppa:linuxmint-tr/araclar
sudo apt update
sudo apt upgrade
sudo apt install -yfm conky conky-all conky-manager conky-manager-extra

exit 0
