#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
if [[ $(command -v docker) ]]
then
  echo "
  Docker is already installed...
  "
  sleep 2s
else
  clear
  echo "
  Installing Docker...
  "
  sudo apt update
  sudo apt-get install -yfm \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
  cd /tmp || exit 1
  mkdir docker
  cd docker || exit 1
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
  sudo gdebi containerd.io_1.2.6-3_amd64.deb
  sudo gdebi docker-ce-cli_19.03.4~3-0~debian-buster_amd64.deb
  sudo gdebi docker-ce_19.03.4~3-0~debian-buster_amd64.deb
  cd .. || exit 1
  sudo rm -rf ./docker
  sudo apt-get update
  sudo groupadd docker
  sudo usermod -aG docker jan
fi
)

exit 0
