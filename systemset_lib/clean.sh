#!/bin/bash
echo "

    Cleaning...

    "

(
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"
echo -e "$YELLOW""Cleaning apt cache...""$ENDCOLOR"
sudo aptitude clean -yf
echo -e "$YELLOW""Removing old config files...""$ENDCOLOR"
sudo aptitude purge -yf "$OLDCONF"
echo -e "$YELLOW""Removing old kernels...""$ENDCOLOR"
sudo aptitude purge -yf "$OLDKERNELS"
sudo dpkg -l linux-{image,headers}-* | awk '/^ii/{print $2}' | grep -E '[0-9]+\.[0-9]+\.[0-9]+' | grep -v "$(uname -r)" | xargs sudo apt-get -y purge
echo -e "$YELLOW""Emptying old bins...""$ENDCOLOR"
rm -rf /**/*Trash*/
rm -rf /**/.*Trash*/
rm -rf /home/**/*tmp*/*
rm -rf /home/**/*tmp*/.*
rm -rf /home/**/*cache*/*
rm -rf /home/**/*cache*/.*
rm -rf /home/jan/.config/**/Application*Cache/*
echo -e "$YELLOW""Updating system...""$ENDCOLOR"
sudo apt-get update
sudo apt-get install -f
sudo apt-get -yfm autoclean
sudo apt-get autoremove -yfm
sudo aptitude purge ~c
sudo dpkg --configure -a
echo -e "$YELLOW""Updating grub...""$ENDCOLOR"
sudo update-grub
echo -e "$YELLOW""Bleachbit...""$ENDCOLOR"
sudo bleachbit -c --sysinfo --preset
sudo -u jan bleachbit -c --sysinfo --preset
echo -e "$YELLOW""Cleaning finished""$ENDCOLOR"
sudo touch /forcefsck
)

exit 0
