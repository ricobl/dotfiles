#!/bin/bash

# Remove UbuntuOne
sudo apt-get remove -q -y --purge ubuntuone-client

# Codecs and JDownloader repositories
sudo add-apt-repository ppa:jd-team/jdownloader
sudo wget --no-verbose --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get -q update && sudo apt-get -y -q --allow-unauthenticated install medibuntu-keyring && sudo apt-get -q update

sudo apt-get install -q -y \
    # Git, vim, meld, pidgin, easy_install, etc...
    git-core git-gui vim-gnome meld pidgin gnome-gmail-notifier compiz-gnome compizconfig-settings-manager \
    cython python-dev libxml2-dev libxslt1-dev libmysqlclient-dev \
    # Install MS Fonts
    msttcorefonts \
    # Install nautilus extension to open terminal
    nautilus-open-terminal \
    # Codecs
    sudo apt-get install -q -y w32codecs libdvdcss2 ubuntu-restricted-extras \
    # JDownloader
    sudo apt-get install -q -y jdownloader


# Reload fonts cache
sudo fc-cache -fv
# Reload nautilus
nautilus -q

# Google Chrome
if [[ -z `which google-chrome` ]]; then
    wget --no-verbose https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    sudo dpkg -i google-chrome-stable_current_i386.deb
    rm google-chrome-stable_current_i386.deb
fi

# Install dotfiles
if [ ! -d ~/projects/dotfiles ]; then
    mkdir -p ~/projects
    pushd ~/projects
    git clone git@github.com:ricobl/dotfiles.git
    . ~/dotfiles/install.sh
    popd
fi

# Setuptools / Pip / Virtualenv / Fabric / ...
wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
rm ez_setup.py

sudo easy_install pip
sudo pip install -q -r ~/projects/dotfiles/pip_requirements.txt
mkdir -p ~/.virtualenvs

