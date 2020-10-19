#!/bin/bash
# TODO: Vyřešit nedodělávku při kompilaci pop shell.
LOGFILE=/home/jan/.logs/systemset.log
(
if [[ $(command -v gnome-help) ]]
then
  echo "
  Installing Pop shell...
  "
  cd /tmp || exit 1
  sudo apt install node-typescript make
  sudo -u jan git clone https://github.com/pop-os/shell
  cd shell || exit 1
  sudo -u jan ./rebuild.sh
  cd .. || exit 1
  rm -rf ./shell
else
  echo "
  Gnome is not presented. Cannot install Pop Shell...
  "
fi
)  2>> "$LOGFILE"
exit 0
