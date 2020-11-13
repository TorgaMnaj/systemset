#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log
echo "

    Installing core applications...

    "
(
appsToInstall=(
wget openssh-server openssh-client git bleachbit geany geany-plugins
sqlitebrowser keepassx luckybackup ufw gufw guake tree htop zenity
catfish hardinfo mariadb-server gigolo curl lrzip vlc remastersys
gparted gnome-disk-utility clipit notify-send htop transmission-gtk
keepassx chromium chromium-browser libminizip1 libre2-3 gcc thunderbird
build-essential cmake autoconf automake pkg-config libtool libzip-dev
libxml2-dev gnome-maps klavaro gnome-tweak-tool deja-dup uget idle bc
jq curl shellcheck yakuake gdebi synaptic pylint gnome-builder gnome-todo
gnome-tweaks gnome-tweak-tool gnome-phone-manager gitg
)
for app in "${appsToInstall[@]}"
do
    sudo apt install -qyf --assume-yes "$app"
done
)  2>> "$LOGFILE"

exit 0
