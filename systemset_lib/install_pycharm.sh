#!/bin/bash

PYCHARMV=https://download-cf.jetbrains.com/python/pycharm-community-2020.2.3.tar.gz

if [ -d /opt/pycharm ]
then
  echo "
  Pycharm je již nainstalován..."
    exit 0
fi
echo "

Installing Pycharm...

"
cd /opt || exit 1
wget $PYCHARMV
tar -xf pycharm*
rm -f ./*.tar.gz
mv pycharm-* pycharm
chown -R "$SUDO_USER" ./pycharm
cd pycharm || exit 1
cd bin || exit 1
p=$(pwd)
m=/pycharm.sh
mm=/pycharm
p=/usr/local/bin
sudo ln -sf "$p$m" "$p$mm"

exit 0

