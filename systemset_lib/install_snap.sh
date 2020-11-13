#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
if command -V snap
then
  echo "

  Installing Snap applications...

  "
  sudo snap install sublime-text --classic
  sudo snap install code --classic
  sudo snap install colibri
  sudo snap install fromscratch
  sudo snap install beekeeper-studio
  sudo snap install jupyter
  sudo snap install netron
  sudo snap install dbeaver-ce
  sudo snap install dbeaverapp
fi
)  2>> "$LOGFILE"

exit 0
