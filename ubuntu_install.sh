#!/bin/bash

# Git, vim, meld, pidgin, easy_install, etc...
sudo apt-get install git-core vim-gnome meld pidgin python-setuptools gnome-gmail-notifier gnome-games

# Install MS Fonts and reload
sudo apt-get install msttcorefonts 
sudo fc-cache -fv

# Install nautilus extension to open terminal and reload
sudo apt-get install nautilus-open-terminal
nautilus -q

# Google Chrome
wget https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_i386.deb
dpkg -i google-chrome-stable_current_i386.deb
rm google-chrome-stable_current_i386.deb

# Install dotfiles
mkdir projects
pushd projects
git clone git@github.com:ricobl/dotfiles.git
./dotfiles/install.sh
popd

# Pip / Virtualenv / Fabric / ...
sudo easy_install pip
sudo pip install -r projects/dotfiles/pip_requirements.txt
mkdir ~/.virtualenvs

# Codecs
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update
sudo aptitude -y install w32codecs libdvdcss2 ubuntu-restricted-extras

# JDownloader
sudo add-apt-repository ppa:jd-team/jdownloader
sudo apt-get install jdownloader

# Fix sound not playing (repeat after every kernel update, unless it's fixed...)
# sudo add-apt-repository ppa:ubuntu-audio-dev/ppa
# sudo apt-get update
# sudo apt-get install linux-alsa-driver-modules-$(uname -r)
# # Open alsamixer and raise Speaker volume
# alsamixer
# Save sound settings to ensure settings are reloaded after rebooting
# sudo alsactl store 0

