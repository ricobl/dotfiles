#!/bin/bash

# Remove UbuntuOne
sudo apt-get remove -q -y --purge ubuntuone-client

sudo apt-get install -q -y \
    # Git, vim, meld, pidgin, easy_install, etc...
    git-core git-gui vim-gnome meld pidgin gnome-gmail-notifier compiz-gnome compizconfig-settings-manager \
    cython python-dev libxml2-dev libxslt1-dev libmysqlclient-dev \
    # Install MS Fonts
    msttcorefonts \
    # Install nautilus extension to open terminal
    nautilus-open-terminal \
    # Codecs
    sudo apt-get install -q -y w32codecs libdvdcss2 ubuntu-restricted-extras


# Reload fonts cache
sudo fc-cache -fv
# Reload nautilus
nautilus -q
