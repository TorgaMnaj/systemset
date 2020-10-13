#!/bin/bash

echo "

        Aktualizuji python pip ...

        "
pip3 install -U pip wheel setuptools
pip3 install setuptools --upgrade
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
# Aktualizace pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U

exit 0