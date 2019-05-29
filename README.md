# My dotfiles and scripts

## Contents

* bash setup, .bashrc and aliases
* bin: useful scripts
* vim: gVim and Vim setup, plugins

## Installation

Clone the repository and run the installation script:

```sh
git clone git://github.com/ricobl/dotfiles.git
./dotfiles/install.sh
```

It will create symlinks in the home directory for everything on `dotfiles/` and also a `~/bin` symlink.

The script avoids replacing existing files / symlinks, meaning that you have to remove anything you want replaced.

## Scripts / bin

The included `.bashrc` adds `~/bin` to the `PATH` so it's easy to use custom scripts.