#!/bin/bash
#Copyright (c) 2020 Jan Magrot

# Protože jsou uživatelská data ve šložce aplikace budeme instalovat do homedir:

if [ -d chromium-latest-linux ]
then
  echo -e "

  Chromium je již zkompilováno.
  Ukončuji.

  "
  exit 1
else
  cd /home/jan/lib/ || exit 1
  git clone https://github.com/scheib/chromium-latest-linux.git && cd chromium-latest-linux || exit 1 && bash update-and-run.sh
fi

exit 0
