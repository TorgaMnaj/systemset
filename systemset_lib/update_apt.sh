#!/bin/bash
clear
echo "

        System update ...

        "

(
sudo apt-get update
sudo apt-get upgrade -yfm
sudo dpkg --configure -a
sudo apt-get -qfy install
sudo apt-get upgrade -yfm
sudo apt-get autoremove -yfm
sudo apt-get autoclean
)

exit 0
