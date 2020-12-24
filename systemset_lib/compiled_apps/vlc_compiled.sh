#!/bin/bash
clear

sudo apt-get purge -yfm vlc && printf "\n\nMažu nainstalovaný VLC, aby jsem ho mohl\nznovu zkompilovat.\n\n"

if [ -d /opt/vlc ]
then
  echo -e "

  VLC je již zkompilováno v /opt-
  Ukončuji.

  "
  exit 1
else
  echo -e "

  Kompilace VLC playeru.

  "
  sudo apt-get install -yfm flex bison autopoint libdvdcss2 lua5.1 lua5.2
  sudo apt install libdvd-pkg && sudo dpkg-reconfigure libdvd-pkg
  cd /opt || exit 1
  echo -e "Clonning VLC..."
  git clone https://github.com/videolan/vlc.git --depth 2 && cd vlc || exit 1
  echo -e "Bootstraping for VlC..."
  sudo ./bootstrap && echo -e "Compiling VLC..." && \
  sudo ./configure && \
  sudo make && \
  sudo make install && \
  echo -e "\nKompilace VLC byla úspěšná.\n"
  sleep 3s
fi

exit 0
