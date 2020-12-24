#!/bin/bash
# TODO: dokončit.
systemctl stop clamav-daemon
systemctl disable clamav-daemon

# preparation:
mkdir /tmp/infected
if [[ ! -e /home/jan/.logs/clamav ]]
then
  mkdir /home/jan/.logs/clamav
fi

touch /home/jan/.logs/clamav/clamav.log && touch /home/jan/.logs/clamav/freshclam.log && touch /home/jan/.logs/clamav/clamscan.log || exit 1
sudo usermod -a -G adm syslog
sudo usermod -a -G adm jan

# run
# /etc/clamav/clamd.conf
# /etc/clamav/freshclam.conf

clear

echo "


Running clamd scan set........."

# sudo cp -rf ./config/clamd.conf /etc/clamav/clamd.conf
# sudo cp -rf ./config/freshclam.conf /etc/clamav/freshclam.conf

echo "
Running clamdscan...
"
# sudo clamdscan -mz --reload --multiscan -c /etc/clamav/clamd.conf --move=/tmp/infected /home/jan
# sudo clamdscan -mz --reload --multiscan -c /etc/clamav/clamd.conf --move=/tmp/infected /

echo "


Running clamscan set........."
echo "
Freshclam...
"
sudo freshclam -v --stdout --show-progress --config-file=/etc/clamav/freshclam.conf
cd /
echo "
Clamscan...
"
# sudo clamscan -iorz --bell --log=/home/jan/.logs/clamav/clamscan.log --move=/tmp/infected /
echo "
Clamscan has finished......
Press Enter to continue...
"
read -r > /dev/null

# Printing sumaries of the quarantine folder.
[ "$(ls -A /tmp/infected)" ] && echo -e "\n\nINFECTED FILES MOVED TO /tmp/infected !!" || printf "\n\nNo infection
found"

exit 0
