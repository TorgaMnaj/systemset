#!/bin/bash
(
if [[ $(command -v gnome-help) ]]
then
  echo "
  Installing Pop shell...
  "
  cd /opt || exit 1
  sudo apt install node-typescript make git
  sudo git clone https://github.com/pop-os/shell.git
  cd shell || exit 1
  sudo make local-install
  cd .. || exit 1
  sudo rm -rf ./shell
else
  echo "
  Gnome is not presented. Cannot install Pop Shell...
  "
  sleep 5
fi
)
exit 0
