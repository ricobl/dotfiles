#!/bin/bash

gconftool-2 --recursive-unset /apps/panel
killall gnome-panel
