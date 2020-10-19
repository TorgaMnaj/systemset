#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

(
clear
echo "Scanning homedir with clamdscan..."
sudo clamdscan -m --reload --quiet /home/jan
sudo clamdscan -m --reload --quiet /home/jan
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
)  2>> "$LOGFILE"

exit 0
