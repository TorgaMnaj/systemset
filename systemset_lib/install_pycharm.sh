#!/bin/bash

echo "

Installing Pycharm...

"

PYCHARMV=https://download-cf.jetbrains.com/python/pycharm-community-2020.2.3.tar.gz

if [ -d /opt/pycharm ]
then
    sudo rm -rf /opt/pycharm
fi
cd /opt || exit 1
wget $PYCHARMV
tar -xf pycharm*
rm -f ./*.tar.gz
mv pycharm-* pycharm
chown -R "$SUDO_USER" ./pycharm
cd pycharm || exit 1
cd bin || exit 1
sudo -u "$SUDO_USER" ./pycharm.sh &

exit 0

