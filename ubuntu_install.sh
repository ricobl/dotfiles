#!/bin/bash

# Git, vim, meld, pidgin, easy_install, etc...
sudo apt-get install -y git git-core vim-gnome meld python-pip gnome-gmail-notifier
sudo apt-get install -y cython python-dev libxml2-dev libxslt1-dev

# Install MS Fonts and reload
sudo apt-get install -y msttcorefonts 
sudo fc-cache -fv

# Install nautilus extension to open terminal and reload
sudo apt-get install -y nautilus-open-terminal
nautilus -q

# Google Chrome
wget https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_i386.deb
sudo dpkg -i google-chrome-stable_current_i386.deb
rm google-chrome-stable_current_i386.deb

# Install dotfiles
if [ ! -d ~/projects/dotfiles ]; then
    mkdir -p projects
    pushd projects
    git clone git@github.com:ricobl/dotfiles.git
    ./dotfiles/install.sh
    popd
    
fi

# Pip / Virtualenv / Fabric / ...
sudo pip install -r projects/dotfiles/pip_requirements.txt
mkdir -p ~/.virtualenvs

# Codecs
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update
sudo apt-get install -y w32codecs libdvdcss2 ubuntu-restricted-extras

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

