#!/bin/bash

clear

echo -e "

Installing Czech locales.

"

apt-get install console-data
apt-get install console-setup
apt-get install console-locales
apt-get install keyboard-configuration

# locales
locale-gen en_US en_US.UTF-8 cs_CZ cs.CZ-UTF8
localedef -i en_US -f UTF-8 en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
sh -c "echo 'LANG=cs.CZ-UTF8\nLC_ALL=en.US_UTF8' > /etc/default/locale"
clear
echo "

Nyní budeme konfigurovat system wide locales.

Nastavíme kódování UTF-8 unicode pro celý systém.
Je důležité toto dělat opatrně.!

Nejdříve zvolte z výběru jazyků en.US_UTF8 + cs.CZ_UTF8
a poté budete vyzváni k nastavení výchozího jazyka.
Jako výchozí kódování nastavte en.US_UTF8,
jako sekundární se samo nastaví cs.CZ-UTF8 !!!
Neprohodit !!!

Pro pokračování zmáčkněte enter.

"
read -r ienter > /dev/null
sudo dpkg-reconfigure locales

# synchronizace času
echo "

Synchronizing time.

"
dpkg-reconfigure tzdata

exit 0
