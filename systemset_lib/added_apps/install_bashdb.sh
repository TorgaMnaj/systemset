#!/bin/bash


if [[ ! "$(command -v bashdb)" ]]
then
  echo -e "
  Installing Bashdb...

  "
  DL=https://deac-ams.dl.sourceforge.net/project/bashdb/bashdb/5.0-1.1.2/bashdb-5.0-1.1.2.tar.gz
  umask 022
  cd /opt || exit 1
  sudo wget "$DL" && sudo tar -xvf bashdb*.tar.gz && sudo rm -rf bashdb*.tar.gz && cd ./bashdb-5.0-1.1.2 && sudo ./configure \
  && sudo make && sudo make check
  sudo su -c 'make install'
else
  echo "
  Bashdb is already installed...
  Aborting...

  "
  sleep 2s
fi

exit 0
