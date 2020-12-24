#!/bin/bash

PYCHARMV=https://download-cf.jetbrains.com/python/pycharm-community-2020.3.1.tar.gz
if [ -d /opt/pycharm ]
then
  echo "

  Pycharm is already installed..."
  exit 0
fi
echo "

Installing Pycharm...

"
cd /opt || exit 1
echo "

Downloading Pycharm...

"
wget --progress=bar:force $PYCHARMV
tar -xf pycharm* && rm -f ./*.tar.gz
mv pycharm-* pycharm
chown -R jan ./pycharm
cd pycharm || exit 1
cd bin || exit 1
aa="

Starting Pycharm - please create comand-line launcher and desktop entry under Tools window.

"
echo "$aa"
notify-send "$aa"
sleep 3s
sudo -u jan bash pycharm.sh

exit 0




