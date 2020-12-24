#!/bin/bash
clear
echo -e "


Kompilace Guake Terminálu.

"

apt-get purge -yfm guake && printf "\n\nMažu nainstalovaný Guake, aby jsem ho mohl\nznovu zkompilovat.\n\n"

if [ -d /opt/guake ]
then
  echo -e "

  Guake je již zkompilováno v /opt-
  Ukončuji.

  "
  exit 1
else
  cd /opt || exit 1
  echo -e "Clonning Guake..."
  git clone https://github.com/Guake/guake.git && cd guake || exit 1
  echo -e "Bootstraping for Guake..."
  sudo ./scripts/bootstrap-dev-debian.sh run make && \
  echo -e "Compiling Guake..." && \
  make && \
  sudo make install && echo -e "\nKompilace Guake Terminálu byla úspěšná.\n"
fi


exit 0
