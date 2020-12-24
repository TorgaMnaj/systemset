#!/bin/bash
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
)

exit 0
