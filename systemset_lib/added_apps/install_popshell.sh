#!/bin/bash
(
if [[ $(command -v gnome-help) ]]
then
  echo "
  Installing Pop shell...
  "
  cd /opt || exit 1
  sudo apt install node-typescript make git
  sudo -u jan git clone https://github.com/pop-os/shell
  cd shell || exit 1
  sudo -u jan make local-install
  cd .. || exit 1
  rm -rf ./shell
else
  echo "
  Gnome is not presented. Cannot install Pop Shell...
  "
fi
)
exit 0
