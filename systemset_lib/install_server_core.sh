#!/bin/bash
clear

echo "

        Starting installation server core applications...

"

appsToInstall=(
automake autoconf cmake build-essential cmakeautoconf
cython3 tree htop curl ipscan net-tools
git ssh openssh-client openssh-server
nano wget screen tmux ntp
)

for app in "${appsToInstall[@]}"
do
    apt-get install -yqf "$app"
done