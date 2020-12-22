#!/ibn/bash
LOGFILE=/home/jan/.logs/systemset.log
echo "

    Installing Python packages...

    "
# apt install basic python packages
(
appsToInstall=(
python3 python3-venv cython3 cython3-dbg
python3-dev python3-pip idle-python3
python3-pytest schroot debootstrap
)
for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qy --assume-yes "$app"
done
)

# pip3 install system wide pzthon3 packages
(
appsToInstall=(
distlib dev setuptools shutil pytest pydrive
)
for app in "${appsToInstall[@]}"
do
    sudo pip# install "$app"
done
)

exit 0
