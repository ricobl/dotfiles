#!/usr/bin/env bash

value=$(defaults read com.apple.Finder AppleShowAllFiles)

[[ "$value" = "true" ]] && value="false" || value="true"

defaults write com.apple.Finder AppleShowAllFiles "$value"
killall Finder
