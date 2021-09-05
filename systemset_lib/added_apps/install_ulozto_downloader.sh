#!/bin/bash

sudo apt install -y tor
sudo pip3 install --upgrade ulozto-downloader
# install tensorflow-lite for python3.9
pip3 install --index-url https://google-coral.github.io/py-repo/ tflite_runtime
# on debian use for tensorflow lite, this instead:
# echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install python3-tflite-runtime

# tkinter
sudo apt install -y python3-tk

# Pro volbu automatického čtení CAPTCHA kódů slouží přepínač --auto-captcha, pro
# volbu počtu částí slouží přepínač --parts N.

# ulozto-downloader --auto-captcha --parts 15 "https://ulozto.cz/file/TKvQVDFBEhtL/debian-9-6-0-amd64-netinst-iso"

# Při využití automatického louskání doporučuji využít velký počet částí, klidně 50
# (spustíte ulozto-downloader a necháte ho pracovat, on si jednou za minutu louskne
# další dva stahovací linky a postupně navyšuje počet najednou stahovaných částí).

exit 0
