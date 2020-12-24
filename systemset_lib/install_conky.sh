#!/bin/bash
(
if ! command -V conky &> /dev/null
then
  echo "

  Installing Conky...

  "
  # TODO: odstranit tento modul.
  sudo apt update
  sudo apt upgrade
  sudo apt install -yfm conky conky-all
else
  echo "

  Conky je již nainstalován...

  "
fi
)

exit 0
