# My dotfiles and scripts

## Contents

* bash: Bash setup, .bashrc and aliases.
* bin: useful scripts (see details below)
* vim: gVim and Vim setup, plugins.

## Installation

    git clone git://github.com/ricobl/dotfiles.git
    ./dotfiles/install.sh

## Useful scripts

* `django-runserver.sh`: starts a Django server for the current project on 0.0.0.0:8000
* `fab_bash_completion`: enables bash completion for Fabric's fabfiles
* `find-file.sh`: finds files whose path or filename matches a pattern
* `git-boot.sh`: initializes a local git repository
* `imgsize.py`: reads image size
* `mass-git`: recursively run any git command on git repositories
* `mount-mysql-mem.sh`: mounts an in-memory filesystem to hold mysql data dir
* `myip`: gives current IP
* `prepend-date`: prepend the current date to a list of filenames
* `pycd`: takes a module name and tries to CD to its directory
* `reset-gnome-panels`: resets gnome-panel to its initial state
* `seek`: finds files containing a regular expression, optionally using a glob pattern
* `seeknot`: finds files NOT containing a regular expression, optionally using a glob pattern
* `togglecaps`: enables or disables CAPS LOCK (runs on Vim, to disable CAPS when exiting command mode)
* `vagrant_bash_completion`: enables bash completion for Vagrant files

