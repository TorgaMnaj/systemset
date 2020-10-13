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

LIBPATH=./systemset_lib/
UPAPT=update_apt.sh
UPPIP=update_pip.sh
REMAPT=remove_apt.sh
INSAPT=install_apt.sh
INSPYAPT=install_python_apt.sh


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
		sudo -u $"SUDO_USER" mkdir ./logs
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

)


exit 0

