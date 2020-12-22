#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log
echo "

    Removing unnecessary applications...

"
(
appsToRemove=(
abiword digikam gnome-mplayer libreoffice-draw seahorse thunderbird
xplayer amarok audacious banshee baobab brasero* entangle enview eog
gedit gimp gnome-mahjongg gnumeric guvcview gw hexchat imagemagick
kaffeine kde-telepathy ksnapshot ktouchpadenabler libreoffice*
libreoffice-base libreoffice-calc libreoffice-impress libreoffice-math
mintstick mtpaint pidgin pix pixeltool rhythmbox-client rhytmbox
simple-scan sylpheed thunderbird* totem xchat* xpad xsane whoopsie apport
apport-gtk ubuntu-report
)
for app in "${appsToRemove[@]}"
do
    sudo apt-get purge -qy --assume-yes "$app"
done
)

exit 0
