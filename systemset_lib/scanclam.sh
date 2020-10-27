#!/bin/bash
LOGFILE=/home/jan/.logs/systemset.log

clear
echo "Scanning homedir with clamdscan..."
sudo clamdscan -m --reload --quiet /home/jan
sudo clamdscan -m --reload --quiet /home/jan
echo "Scanning whole system with clamscan..."
sudo clamscan -ior --remove --bell / 2>> "$LOGFILE" &
echo "
Clamscan běží jako podproces...
"
sleeps 3s

exit 0
