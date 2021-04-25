#!/bin/bash
clear
if [[ $(command -v mariadb) ]]
then
  echo -e "\nMariadb is already installed.\n"
  sleep 2s
  exit 0
else
  echo -e "\nInstalling and seting up MariaDB Server.\n"
  sudo apt-get install -yfm mariadb-server
  echo -e "Now we will setup Mariadb server, first verify that mariadb is running."
  echo -e "Open another terminal and place folowing command to Your terminal:"
  echo -e "sudo systemctl status mariadb"
  echo -e "Press ENTER to continue."
  # shellcheck disable=SC2034
  read -r answ > /dev/null
  echo -e "Now setup ROOT password:"
  echo -e "mysqladmin -u root password EnterYourPasswordHere"
  echo -e "Press ENTER to continue."
  # shellcheck disable=SC2034
  read -r answ > /dev/null
  echo -e  "Now check Your new password. Write in terminal:"
  echo -e "mysql -u root -p EnterYourPasswordHere"
  echo -e "Press ENTER to continue."
  # shellcheck disable=SC2034
  read -r answ > /dev/null
  echo -e "Now You will secure the installation. Paste folowing in terminal:"
  echo -e "sudo mysql_secure_installation"
  echo -e "All steps are explained in detail. Basically answer YES is recomended everywhere."
  echo -e "Finished"
  echo -e "Press ENTER to continue."
  # shellcheck disable=SC2034
  read -r answ > /dev/null
fi