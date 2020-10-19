#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log
(
if [[ ! -d ~/bin ]]
then
  mkdir ~/bin
fi
if [[ ! -d ~/lib ]]
then
  mkdir ~/lib
fi

cp -f ./systemset.sh ~/bin/ && chmod 700 ~/bin/systemset.sh
cp -rf ./systemset_lib ~/lib/ && chmod 700 ~/lib/systemset_lib/*
)  2>> "$LOGFILE"

exit 0
