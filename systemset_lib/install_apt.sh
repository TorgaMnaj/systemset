#!/bin/bash

(
if [[ $(command -v gnome-help) ]]
then
  echo "

    Installing Gnome extensions...

    "
  appsToInstall=(
  gnome-disk-utility gnome-tweak-tool gnome-calendar
  gnome-calculator gnome-calls gnome-contacts gnome-documents gnome-gmail gnome-logs
  gnome-maps gnome-phone-manager gnome-photos gnome-shell gnome-shell-extension-gsconnect
  gnome-shell-extension-gsconnect-browsers gnome-shell-extension-weather
  gnome-system-log gnome-todo gnome-tweaks
  )
  for app in "${appsToInstall[@]}"
  do
      sudo apt-get install -qyf --assume-yes "$app"
  done
fi
)


echo "

    Installing core applications...

    "
(
appsToInstall=(
wget openssh-server openssh-client git bleachbit geany geany-plugins
sqlitebrowser keepassx luckybackup ufw gufw tree htop zenity
catfish hardinfo gigolo curl lrzip remastersys
gparted diodon notify-send transmission-gtk vlc chromium-browser
libminizip1 libre2-3 gcc conky conky-all synaptic
build-essential cmake autoconf automake pkg-config libtool libzip-dev
libxml2-dev klavaro deja-dup uget idle bc backupninja
jq curl shellcheck gdebi ubuntu-report lm-sensors oprofile collectl
duc stress youtube-dl net-tools nmap standard-notes everdo
gnome-shell-extension-gsconnect kanyremote kdeconnect
)
for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qyf --assume-yes "$app"
done
)

exit 0
