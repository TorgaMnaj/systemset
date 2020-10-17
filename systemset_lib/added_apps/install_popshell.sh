#!/bin/bash
# TODO: Vyřešit nedodělávku při kompilaci pop shell.

if [[ $(command -v gnome-help) ]]
then
  echo "
  Installing Pop shell...
  "
  cd /tmp || exit 1
  sudo apt install node-typescript make
  sudo -u "$SUDO_USER" git clone https://github.com/pop-os/shell
  cd shell || exit 1
  sudo -u "$SUDO_USER" ./rebuild.sh
  cd .. || exit 1
  rm -rf ./shell
else
  echo "
  Gnome is not presented. Cannot install Pop Shell...
  "
fi
exit 0
