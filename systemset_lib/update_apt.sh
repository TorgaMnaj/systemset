#!/bin/bash

clear
echo "

        Aktualizuji systém ...

        "
sudo apt-get update
sudo apt-get -qfy install
sudo dpkg --configure -a
sudo apt-get autoremove -yfm
sudo apt-get -qy dist-upgrade
sudo apt-get autoclean
sudo apt autoremove

exit 0