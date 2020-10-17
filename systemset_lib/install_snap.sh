#!/bin/bash

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

exit 0
