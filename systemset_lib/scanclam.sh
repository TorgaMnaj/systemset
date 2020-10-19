#!/bin/bash
clear
echo "Scanning homedir with clamdscan..."
sudo clamdscan -m --reload --quiet /home/"$SUDO_USER"
sudo clamdscan -m --reload --quiet /home/"$SUDO_USER"
echo "Scanning whole system with clamscan..."
(
cd /
a="/"
for f in *
do
  if [ -d "$f" ]
  then
    sudo clamscan -ior --remove --bell "$a$f" &
  fi
done
)

sleep 3s
exit 0
