#!/bin/bash

sudo pip3 install --upgrade ulozto-downloader
# install tebsorflow-lite for python3.8
sudo pip3 install https://github.com/google-coral/pycoral/releases/download/release-frogfish/tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl
# tkinter
sudo apt install -y python3-tk

# Pro volbu automatického čtení CAPTCHA kódů slouží přepínač --auto-captcha, pro
# volbu počtu částí slouží přepínač --parts N.

# ulozto-downloader --auto-captcha --parts 15 "https://ulozto.cz/file/TKvQVDFBEhtL/debian-9-6-0-amd64-netinst-iso"

# Při využití automatického louskání doporučuji využít velký počet částí, klidně 50
# (spustíte ulozto-downloader a necháte ho pracovat, on si jednou za minutu louskne
# další dva stahovací linky a postupně navyšuje počet najednou stahovaných částí).

exit 0
