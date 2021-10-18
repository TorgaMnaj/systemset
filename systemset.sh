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
# TODO: Předělat uživatele jan na SUDOUSER !

if [ -d ./systemset_lib/ ]
then
	LIBPATH=./systemset_lib/
else
  if [ -d /home/jan/lib/systemset_lib/ ]
	then
	  LIBPATH=/home/jan/lib/systemset_lib/
	else
	  echo -e "Systemset_lib is missing! \nTerminating...\n"
	  exit 1
	fi
fi

# logs:
# TODO: logging háže chyby a nevím proč. Předělat logging přes fifo.
if [[ ! -d /home/jan/.logs/ ]]
then
  mkdir /home/jan/.logs/
fi
sudo chown jan /home/jan/.logs/
LOGFILE=/home/jan/.logs/systemset.log

echo -e "

Logfile je umístěno v /home/jan/.logs/systemset.log

"
date -u +"

%Y-%m-%d   %H:%M:%SZ

" > "$LOGFILE"


# core_apps
UPAPT=update_apt.sh
UPPIP=update_pip.sh
REMAPT=remove_apt.sh
INSAPT=install_apt.sh
INSPYAPT=install_python_apt.sh
INSPYCHARM=install_pycharm.sh
INSSNAP=install_snap.sh
CLEAN=clean.sh
SECURE=secure.sh
SCAN=scanclam.sh
INSERVERCORE=install_server_core.sh
INSLOCALES=install_locales.sh
# added_apps:
INSTALIB=added_apps/install_talib.sh
INSVIRTBOX=added_apps/install_virtualbox.sh
INSDOCK=added_apps/install_docker.sh
INSPOP=added_apps/install_popshell.sh
INSBASHDB=added_apps/install_bashdb.sh
INSBASDDD=added_apps/install_ddd.sh
INSULOZTO=added_apps/install_ulozto_downloader.sh
INSMARIADB=added_apps/install_mariadb.sh
# compiled apps:
COMPILECHROMIUM=compiled_apps/chromium_compiled.sh
COMPILEGUAKE=compiled_apps/guake_compiled.sh
COMPILEVLC=compiled_apps/vlc_compiled.sh


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

choose_system () {
quit=false
until "$quit"
do
  clear
  echo "

  Run script for Desktop or Server system?
  a) Desktop
  b) Server
  q) quit

  "
  read -r lans
  case $lans in
  a|A)
    echo "

    Running desktop tasks.

    "
    sleep 1s
    firstrun_case
    run_case
    clear
    quit=true
    break
    ;;
  b|B)
    echo "

    Running server tasks.

    "
    clear
    firstrun_server_case
    run_server_case
    quit=true
    break
    ;;
  q|Q)
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
}

firstrun_server_scripts () {
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$CLEAN"
sudo bash "$LIBPATH$REMAPT"
sudo bash "$LIBPATH$INSERVERCORE"
sudo bash "$LIBPATH$INSPYAPT"
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$CLEAN"
sudo bash "$LIBPATH$SECURE"
}


firstrun_server_case () {
installed=false
if [[ ! -e /home/jan/.firstrun ]]
then
  until "$installed"
  do
    echo "
    I see script is about to run for first time,
    Would you like to run its core tasks automaticaly?
    (includes: update system, uninstall unnecesary applications,
    installing server core applications, installing python components,
    installing system wide TaLib, installing docker, cleaning system and
    securing system). y/n
    "
    read -r answ
    case $answ in
    y|Y)
      firstrun_server_scripts
      installed=true
      touch /home/jan/.firstrun && chmod -f 000 /home/jan/.firstrun && chown -f jan \
      /home/jan/.firstrun
      clear
      echo "

      Applications had been succesfully installed and core tasks are done.

      press ENTER
      "
      read -r > /dev/null
      while true:
      do
        echo -e "\nWould You like to install added applications? y/n \n"
        read -r nans
        case $nans in
          y|Y)
          added_apps_install
          final_meassage
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
      sleep 2s
      continue
      ;;
    n|N)
      :
      installed=true
      continue
      ;;
    *)
      echo "
      Wrong answer! Again."
      sleep 2s
      continue
      ;;
    esac
  done
fi
}

run_server_case () {
while true
do
  clear
  echo "
  Choose action:
  a) Update system
  b) Clean system
  c) Secure system
  d) Remove unnecesary applications
  e) Install core applications
  f) Run whole server system setup
  g) Enter additional application install menu
  h) Scanclam and clamdscan system
  i) Install Czech locales and time synchronization
  q) Quit"
  read -r myanswer
  case $myanswer in
  a|A)
    sudo bash "$LIBPATH$UPAPT"
    ;;
  b|B)
    sudo bash "$LIBPATH$CLEAN"
    ;;
  c|C)
    sudo bash "$LIBPATH$SECURE"
    ;;
  d|D)
    sudo bash "$LIBPATH$REMAPT"
    ;;
  e|E)
    sudo bash "$LIBPATH$INSERVERCORE"
    ;;
  f|F)
    firstrun_server_scripts
    ;;
  g|G)
    added_apps_install
    ;;
  h|H)
    sudo bash "$LIBPATH$SCAN"
    ;;
  i|I)
  sudo bash "$LIBPATH$INSLOCALES"
    ;;
  q|Q)
    final_meassage
    sleep 2s
    break
    ;;
  *)
    echo "

    Wrong choise. Again.

    "
    sleep 2s
    ;;
  esac
done
}


firstrun_case () {
installed=false
if [[ ! -e /home/jan/.firstrun ]]
then
  until "$installed"
  do
    echo "

    I see script is about to run for first time,
    Would you like to run its core tasks automaticaly?
    (includes: update system, uninstall unnecesary applications,
    installing favourite applications via APT, installing favourite
    applications via SNAP if presented, installing python components,
    installing conky, installing pycharm and securing system). y/n

    "
    read -r answ
    case $answ in
    y|Y)
      firstrun_scripts
      installed=true
      touch /home/jan/.firstrun && chmod -f 000 /home/jan/.firstrun && chown -f jan \
      /home/jan/.firstrun
      sudo sensors-detect --auto
      clear
      echo "

      Core applications had been succesfully installed and core tasks are done.

      press ENTER
      "
      read -r > /dev/null
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
      sleep 2s
      continue
      ;;
    n|N)
      :
      installed=true
      break
      ;;
    *)
      echo "
      Wrong answer! Again."
      sleep 2s
      ;;
    esac
  done
fi
}

firstrun_scripts () {
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$REMAPT"
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$INSAPT"
sudo bash "$LIBPATH$INSPYAPT"
sudo bash "$LIBPATH$INSSNAP"
sudo bash "$LIBPATH$INSPYCHARM"
sudo bash "$LIBPATH$INSPOP"
sudo bash "$LIBPATH$COMPILEGUAKE"
sudo bash "$LIBPATH$SECURE"
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$UPPIP"
sudo bash "$LIBPATH$CLEAN"
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
  h) Run whole desktop system setup
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
    sudo bash "$LIBPATH$INSPYAPT"
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
    final_meassage
    sleep 2s
    break
    ;;
  *)
    echo "

    Whong choise. Again.

    "
    ;;
  esac
done
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
  e) install Bashdb
  f) install Ddd
  g) install Ulozto Downloader
  h) install MariaDB Server
  i) compile Guake
  j) compile Vlc
  k) compile Chromium
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
    e|E)
    sudo bash "$LIBPATH$INSBASHDB"
    clear
    continue
    ;;
    f|F)
    sudo bash "$LIBPATH$INSBASDDD"
    clear
    continue
    ;;
    g|G)
    sudo bash -v "$LIBPATH$INSULOZTO"
    clear
    continue
    ;;
    h|H)
    sudo bash "$LIBPATH$INSMARIADB"
    clear
    continue
    ;;
    i|I)
    sudo bash "$LIBPATH$COMPILEGUAKE"
    clear
    continue
    ;;
    j|J)
    sudo bash "$LIBPATH$COMPILEVLC"
    clear
    continue
    ;;
    k|K)
    sudo bash "$LIBPATH$COMPILECHROMIUM"
    clear
    continue
    ;;
    q|Q)
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
}

final_meassage () {
clear
echo "

Script has succesfully finished...

"
}

#Execution:

clear
preparation
connectioncontrol
choose_system
exit 0
