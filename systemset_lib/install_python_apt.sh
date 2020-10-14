#!/ibn/bash

echo "

    Installing Python packages...

    "
appsToInstall=(
python3 python3-venv python3-numpy cython3 cython3-dbg python3-distlib
python3-dev python3-pip python3-scipy idle-python3 python3-distlib
python3-dev python-setuptools python-pip python3-matplotlib
pyhon3-shutil python3-scipy python-pip python-qt4 python3-pytest
python3-pyqt4 schroot debootstrap python3-pydrive
)
for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qy --assume-yes "$app"
done

exit 0
