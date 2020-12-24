#!/bin/bash
echo "

        Updating python pip ...

        "

(
pip3 install -U pip wheel setuptools
pip3 install setuptools --upgrade
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
# Aktualizace pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
)

exit 0
