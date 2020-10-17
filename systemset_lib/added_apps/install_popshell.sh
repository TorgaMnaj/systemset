#!/bin/bash
# TODO: Zkontrolovat zda je nainstalováno gnome a není přítomno pop shell,
# TODO: Vyřešit nedodělávku při kompilaci pop shell.
echo "

Installing Pop shell...

"
# TODO: přepsat "$SUDO_USER" na
 cd /tmp || exit 1
sudo apt install node-typescript make
sudo -u "$SUDO_USER" git clone https://github.com/pop-os/shell
cd shell || exit 1
sudo -u "$SUDO_USER" ./rebuild.sh
cd .. || exit 1
rm -rf ./shell

exit 0
