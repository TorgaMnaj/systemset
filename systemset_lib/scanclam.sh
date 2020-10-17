#!/bin/bash
clear
echo "Scanning homedir with clamdscan..."
sudo clamdscan -m --reload --quiet /home/"$SUDO_USER"
sudo clamdscan -m --reload --quiet /home/"$SUDO_USER"
echo "Scanning whole system with clamscan..."
sudo clamscan -ior --remove --bell /
exit 0
