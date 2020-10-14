#!/bin/bash

if [ ! -d ~/bin ]
then
    mkdir ~/bin
fi
cp -f ./systemset.sh ~/bin/systemset.sh
if [ ! -d ~/lib ]
then
    mkdir ~/lib
fi
cp -rf ./systemset_lib ~/lib/systemset_lib

exit 0