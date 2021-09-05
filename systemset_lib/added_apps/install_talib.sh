#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

coreinstall () {
  if [[ ! -d /usr/local/lib/ta-lib ]]
  then
    echo "

        Downloading, compiling and installing system wide talib and installing local talib via pip3...

        "
    # Install base ta-lib systemwide (sudo)
    cd /opt || exit 1
    sleep 1s
    wget http://freefr.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz || wget \
    http://softlayer-ams.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz && \
    tar -xvzf ./*.tar.gz && rm -rf ./*.tar.gz
    sleep 1s
    cd ta-lib || exit 1
    ./configure --prefix=/usr
    make
    make install && pip3 install TA-Lib
    clear
  else
    echo "

    Ta_Lib is already installed..

    "
    sleep 2s
  fi
   }

(
if [[ ! -d "/usr/local/lib/python3*/dist-packages/talib" ]]
then
    if [[ ! -d "/usr/lib/python3*/dist-packages/talib" ]]
    then
        coreinstall
    fi
fi
)

exit 0
