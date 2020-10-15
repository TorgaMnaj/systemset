#!/bin/bash

echo "

    Installing core applications...

    "
appsToInstall=(
wget openssh-server openssh-client git bleachbit geany geany-plugins 
sqlitebrowser keepassx luckybackup ufw gufw guake tree htop zenity 
catfish hardinfo mariadb-server gigolo curl lrzip vlc remastersys 
gparted gnome-disk-utility clipit notify-send htop transmission-gtk 
keepassx chromium chromium-browser libminizip1 libre2-3 gcc 
build-essential cmake autoconf automake pkg-config libtool libzip-dev 
libxml2-dev gnome-maps klavaro gnome-tweak-tool deja-dup uget idle bc 
jq curl shellcheck yakuake gdebi
)
for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qyf --assume-yes "$app"
done

exit 0
