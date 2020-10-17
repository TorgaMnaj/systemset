#!/bin/bash
# TODO: Lépe zkontrolovat že talib není nainstalována.
echo "

Installing Talib...

"
coreinstall () {
    echo "

        Downloading, compiling and installing system wide talib and installing local talib via pip3...

        "
    # Install base ta-lib systemwide (sudo)
    if [ -d /usr/local/lib ]
    then
        cd /usr/local/lib || exit 1
    else
        if [ -d /usr/lib ]
        then
            cd /usr/lib || exit 1
        fi
    fi
    rm -rf ./ta-lib*
    sleep 1s
    wget http://freefr.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz || wget http://softlayer-ams.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz && tar -xvzf ./*.tar.gz && rm -rf ./*.tar.gz
    sleep 1s
    cd ta-lib || exit 1
    ./configure --prefix=/usr
    make
    make install
    sleep 1s
    pip3 install TA-Lib
    clear
    }

if [ ! -d /usr/local/lib/python3.4/dist-packages/talib ]
then
    if [ ! -d /usr/lib/python3.4/dist-packages/talib ]
    then
        coreinstall
    fi
fi

exit 0
