#!/bin/bash
echo "

    Installing Python packages...

    "
# apt install basic python packages
(
appsToInstall=(
python3 python python3-venv python-pip
python3-dev python3-pip idle-python3
python3-pytest python3-distutils
python3-distutils-extra cython3 cython3-dbg
)
for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qy --assume-yes "$app"
done
)

# pip3 install system wide packages
(
appsToInstall=(
pysensors
)
for app in "${appsToInstall[@]}"
do
    sudo -u jan pip3 install "$app"
done
)

exit 0

