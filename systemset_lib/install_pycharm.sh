#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
PYCHARMV=https://download-cf.jetbrains.com/python/pycharm-community-2020.2.3.tar.gz

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
wget $PYCHARMV
tar -xf pycharm*
rm -f ./*.tar.gz
mv pycharm-* pycharm
chown -R jan ./pycharm
cd pycharm || exit 1
cd bin || exit 1
sudo -u jan bash pycharm.sh
)  2>> "$LOGFILE"

exit 0

