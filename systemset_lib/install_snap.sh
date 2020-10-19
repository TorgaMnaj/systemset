#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
if command -V snap
then
  echo "

  Installing Snap applications...

  "
  sudo snap install gitkraken --classic
  sudo snap install sublime-text --classic
  sudo snap install code --classic
  sudo snap install colibri
  sudo snap install fromscratch
fi
)  2>> "$LOGFILE"

exit 0
