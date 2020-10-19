#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log
clear
echo "

        System update ...

        "

(
sudo apt-get update
sudo apt-get -qfy install
sudo dpkg --configure -a
sudo apt-get autoremove -yfm
sudo apt-get -qy dist-upgrade
sudo apt-get autoclean
sudo apt autoremove
)  2>> "$LOGFILE"

exit 0
