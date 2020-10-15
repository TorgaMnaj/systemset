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
	LIBPATH=/usr/local/lib/systemset_lib/
fi

UPAPT=update_apt.sh
UPPIP=update_pip.sh
REMAPT=remove_apt.sh
INSAPT=install_apt.sh
INSPYAPT=install_python_apt.sh
INSCONK=install_conky.sh
INSDOCK=install_docker.sh
INSPOP=install_popshell.sh
INSPYCHARM=install_pycharm.sh
INSSNAP=install_snap.sh
INSTALIB=install_talib.sh
INSVIRTBOX=install_virtualbox.sh
CLEAN=clean.sh
SECURE=secure.sh


preparation () {
	clear
	echo "



	Kontroluji oprávnění...



	"
	if [ "$EUID" -ne 0 ]
	then
		echo ""
		echo "  Skript musí běžet s oprávněním správce !  "
		echo ""
		echo "  Ukončuji...  "
		echo ""
		exit 1
	fi
	echo "

	Běžím jako ROOT... V pořádku...

	"

	#

	if [ ! -d ./logs/ ]
	then
		sudo -u "$SUDO_USER" mkdir ./logs
	fi

	LOGFILE="./logs/bigsystemscript.log"

	date -u +"

	%Y-%m-%d   %H:%M:%SZ

	" > $LOGFILE
}

connectioncontrol() {
  clear
  echo "



  Kontroluji připojení k internetu...



  "
  sleep 2s
  echo ""
  # Check the connection by downloading a file from ftp.debian.org. No disk space used.
  if ! wget -O - http://ftp.debian.org/debian/README &> /dev/null
  then
    until [ "$CONT" != "" ]; do
      echo ""
      if ! wget -O - http://ftp.debian.org/debian/README &> /dev/null
      then
        clear
        echo "  Nemáte funkční připojení k internetu!"
        echo ""
        echo "  Tento skript vyžaduje funkční připojení k internetu."
        echo "  Prosím nastavte své připojení."
        clear
        echo "Skript byl přerušen."
        sleep 3s
        exit 1
      else
        CONT="pass"
      fi
    done
  fi
  echo "

  Test připojení k internetu prošel...

  "
  sleep 1s
  }

(
preparation
connectioncontrol
### Basics:
sudo bash "$LIBPATH$UPAPT"
sudo bash "$LIBPATH$UPPIP"
sudo bash "$LIBPATH$REMAPT"
sudo bash "$LIBPATH$INSAPT"
sudo bash "$LIBPATH$INSPYAPT"
### Git and compilations:
sudo bash "$LIBPATH$INSCONK"
sudo bash "$LIBPATH$INSDOCK"
sudo bash "$LIBPATH$INSPOP"
sudo bash "$LIBPATH$INSPYCHARM"
sudo bash "$LIBPATH$INSSNAP"
sudo bash "$LIBPATH$INSTALIB"
sudo bash "$LIBPATH$INSVIRTBOX"
sudo bash "$LIBPATH$CLEAN"
sudo bash "$LIBPATH$SECURE"
)

exit 0

