#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Homebrew/bundle
brew bundle

sudo pip install -q -r pip_requirements.txt

mkdir -p ~/.virtualenvs

xcode-select --install
