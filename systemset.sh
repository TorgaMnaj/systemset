#!/bin/bash
#Copyright (c) 2020 Jan Magrot

#Permission is hereby granted, free of charge, to any person obtaining a
#copy of this software and associated documentation files (the
#'Software'), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:
#The above copyright notice and this permission notice shall be included
#in all copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS
#OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if [ -d ./systemset_lib/ ]
then
	LIBPATH=./systemset_lib/
else
	LIBPATH=/home/jan/lib/systemset_lib/
fi
# logs:
if [[ ! -d /home/jan/.logs/ ]]
then
  mkdir /home/jan/.logs/
fi
sudo chown jan /home/jan/.logs/
LOGFILE=/home/jan/.logs/systemset.log
date -u +"

%Y-%m-%d   %H:%M:%SZ

" > "$LOGFILE"

# core_apps
UPAPT=update_apt.sh
UPPIP=update_pip.sh
REMAPT=remove_apt.sh
INSAPT=install_apt.sh
INSPYAPT=install_python_apt.sh
INSCONK=install_conky.sh
INSPYCHARM=install_pycharm.sh
INSSNAP=install_snap.sh
CLEAN=clean.sh
SECURE=secure.sh
SCAN=scanclam.sh
# added_apps:
INSTALIB=added_apps/install_talib.sh
INSVIRTBOX=added_apps/install_virtualbox.sh
INSDOCK=added_apps/install_docker.sh
INSPOP=added_apps/install_popshell.sh

final_meassage () {
clear
echo "

Script has succesfully finished...

"
}

preparation () {
clear
echo "
Checking permissions..."
if [ "$EUID" -ne 0 ]
then
  echo "  Script must run with root privilages !  "
  echo "  Terminating...  "
  exit 1
fi
echo "Running as root... OK..."
}

connectioncontrol() {
echo "
Checking internet connection..."
sleep 2s
echo ""
# Check the connection by downloading a file from ftp.debian.org. No disk space used.
if ! wget -O - http://ftp.debian.org/debian/README &> /dev/null
then
  until [ "$CONT" != "" ]
  do
    echo ""
    if ! wget -O - http://ftp.debian.org/debian/README &> /dev/null
    then
      echo "You dont have working internet connection!      "
      echo "This script requires working internet connection.      "
      echo "Terminating."
      sleep 3s
      exit 1
    else
      CONT="pass"
    fi
  done
fi
echo "Test for working internet connection has passed..."
sleep 1s
}

added_apps_install () {
quit=false
until "$quit"
do
  clear
  echo "

  Added applications and libraries installation:
  a) install Ta_Lib
  b) install Docker
  c) install Pop Shell
  d) install VirtualBox
  q) quit
  "
  read -r lans
  case $lans in
    a|A)
    sudo bash "$LIBPATH$INSTALIB"
    clear
    continue
    ;;
    b|B)
    sudo bash "$LIBPATH$INSDOCK"
    clear
    continue
    ;;
    c|C)
    sudo bash "$LIBPATH$INSPOP"
    clear
    continue
    ;;
    d|D)
    sudo bash "$LIBPATH$INSVIRTBOX"
    clear
    continue
    ;;
    q|Q)
    echo q
    quit=true
    clear
    break
    ;;
    *)
    echo -e "\n\nWrong choice. Again.\n"
    sleep 1s
    clear
    continue
    ;;
  esac
done
}  2>> "$LOGFILE"

firstrun_scripts () {
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$REMAPT"
sudo bash "$LIBPATH$INSAPT"
sudo bash "$LIBPATH$INSPYAPT"
sudo bash "$LIBPATH$INSCONK"
sudo bash "$LIBPATH$INSPYCHARM"
sudo bash "$LIBPATH$INSSNAP"
sudo bash "$LIBPATH$CLEAN"
sudo bash "$LIBPATH$SECURE"
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$UPPIP"
sudo bash "$LIBPATH$INSPOP"
}  2>> "$LOGFILE"

firstrun_case () {
(
if [[ ! -e /home/jan/.firstrun ]]
then
  while true
  do
    echo "
    I see script is about to run for first time,
    Would you like to run its core tasks automaticaly?
    (includes: update system, uninstall unnecesary applications,
    installing favourite applications via APT, installing favourite
    applications via SNAP if presented, installing python components,
    installing conky, installing pycharm and securing system. y/n "
    read -r answ
    case $answ in
    y|Y)
      firstrun_scripts
      touch /home/jan/.firstrun && chmod -f 000 /home/jan/.firstrun && chown -f jan \
      /home/jan/.firstrun
      clear
      echo "

      Core applications had been succesfully installed and core tasks are done.

      "
      while true:
      do
        echo -e "\nWould You like to install added applications? y/n \n"
        read -r nans
        case $nans in
          y|Y)
          added_apps_install
          break
          ;;
          n|N)
          :
          break
          ;;
          *)
          echo -e "\nWhong choice. Again.\n"
          sleep 1s
          ;;
        esac
      done
      final_meassage
      exit 0
      ;;
    n|N)
      :
      break
      ;;
    *)
      echo "
      Wrong answer! Again."
      ;;
    esac
  done
fi
)  2>> "$LOGFILE"
}

run_case () {
while true
do
  clear
  echo "
  Choose action:
  a) Update system
  b) Update python pip and pip3
  c) Clean system
  d) Secure system
  e) Remove unnecesary applications
  f) Install favourite applications via APT
  g) Install favourite applications via SNAP
  h) Run core scripts for installation, removal and tweaking system
  i) Enter additional application install menu
  j) Scanclam and clamdscan system
  q) Quit"
  read -r myanswer
  case $myanswer in
  a|A)
  sudo bash "$LIBPATH$UPAPT"
  ;;
  b|B)
  sudo bash "$LIBPATH$UPPIP"
  ;;
  c|C)
  sudo bash "$LIBPATH$CLEAN"
  ;;
  d|D)
  sudo bash "$LIBPATH$SECURE"
  ;;
  e|E)
  sudo bash "$LIBPATH$REMAPT"
  ;;
  f|F)
  sudo bash "$LIBPATH$INSAPT"
  ;;
  g|G)
  sudo bash "$LIBPATH$INSSNAP"
  ;;
  h|H)
  firstrun_scripts
  ;;
  i|I)
  added_apps_install
  ;;
  j|J)
  sudo bash "$LIBPATH$SCAN"
  ;;
  q|Q)
  break
  ;;
  *)
  echo "

  Whong choise. Again."
  ;;
  esac

done
}  2>> "$LOGFILE"


#Execution:

clear
preparation
connectioncontrol
firstrun_case
run_case
sudo chmod 755 "$LOGFILE"
sudo chown jan "$LOGFILE"


final_meassage
exit 0

