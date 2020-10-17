#!/bin/bash

if ! command -V conky &> /dev/null
then
  echo "

  Installing Conky...

  "
  sudo add-apt-repository ppa:linuxmint-tr/araclar
  sudo apt update
  sudo apt upgrade
  sudo apt install -yfm conky conky-all conky-manager conky-manager-extra
else
  echo "

  Conky je již nainstalován...

  "
fi

exit 0
