#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
if command -V snap
then
  echo "

  Installing Snap applications...

  "
  echo "
  Installing beekeeper...
  "
  sudo snap install beekeeper
  echo "
  Installing beekeeper-studio...
  "
  sudo snap install beekeeper-studio
  echo "
  Installing sublime...
  "
  sudo snap install sublime-text --classic
  echo "
  Installing Visualcode...
  "
  sudo snap install code --classic
  echo "
  Installing colibri...
  "
  sudo snap install colibri
  echo "
  Installing fromscratch...
  "
  sudo snap install fromscratch

  echo "
  Installing jupyter...
  "
  sudo snap install jupyter
  echo "
  Installing netron...
  "
  sudo snap install netron
  echo "
  Installing dbeaver...
  "
  sudo snap install dbeaver-ce
fi
)

exit 0
