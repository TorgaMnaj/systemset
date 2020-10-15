#!/bin/bash
# TODO: Zkontrolovat možnost lepší instalace.
echo "

Installing Docker...

"

sudo apt-get remove -yfm docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -yfm \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
sudo apt-get update
sudo apt --fix-broken install
cd /tmp || exit 1
mkdir docker
cd docker || exit 1
clear
echo "

		    Downloading .deb packages...

"

wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/containerd.io_1.2.6-3_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce-cli_19.03.4~3-0~debian-buster_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_19.03.4~3-0~debian-buster_amd64.deb
echo "

		    Installing .deb packages of docker...

"
sudo apt install -yfm gdebi
sudo gdebi-gtk containerd.io_1.2.6-3_amd64.deb
sudo gdebi-gtk docker-ce-cli_19.03.4~3-0~debian-buster_amd64.deb
sudo gdebi-gtk docker-ce_19.03.4~3-0~debian-buster_amd64.deb
cd .. || exit 1
sudo rm -rf ./docker
sudo apt-get update
sudo apt --fix-broken install

sudo groupadd docker
sudo usermod -aG docker "$SUDO_USER"

exit 0
