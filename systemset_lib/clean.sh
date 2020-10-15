#!/bin/bash
LOGFILE="./logs/clean.log"
echo "

    Cleaning...

    "

date -u +"

%Y-%m-%d   %H:%M:%SZ

" > $LOGFILE

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"
echo -e "$YELLOW""Cleaning apt cache...""$ENDCOLOR"
sudo aptitude clean -yf
echo -e "$YELLOW""Removing old config files...""$ENDCOLOR"
sudo aptitude purge -yf "$OLDCONF"
echo -e "$YELLOW""Removing old kernels...""$ENDCOLOR"
sudo aptitude purge -yf "$OLDKERNELS"
echo -e "$YELLOW""Emptying old bins...""$ENDCOLOR"
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /home/*/tmp/*/** &> /dev/null
sudo rm -rf /root/.local/share/Trash/*/** &> /dev/null
sudo rm -rf /home/.Trash*/*/** &> /dev/null
sudo rm -rf /*/**/.Trash-1000
rm -rf /home/"$SUDO_USER"/tmp/* &> /dev/null
rm -rf /home/"$SUDO_USER"/tmp/.* &> /dev/null
rm -rf /home/"$SUDO_USER"/.cache* &> /dev/null
rm -rf /home/"$SUDO_USER"/.config/**/Application*Cache/* &> /dev/null
sudo rm -rf /**/tmp/* &> /dev/null
rm -rf /home/"$SUDO_USER"/.backup/* &> /dev/null
rm -rf /home/"$SUDO_USER"/.backup/.* &> /dev/null
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
bleachbit -c --preset
echo -e "$YELLOW""Cleaning finished""$ENDCOLOR"
sudo touch /forcefsck
sudo chown -R "$SUDO_USER" ./logs/**

exit 0
