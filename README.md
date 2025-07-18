# Modular Dotfiles and Scripts

This repository uses a modular structure with `.bashrc` logic, dotfiles and custom scripts distributed across modules.

## Installation

Clone the repository and run the installation script:

```sh
git clone git://github.com/ricobl/dotfiles.git
./scripts/install.sh
```

It will create symlinks in the home directory pointing to files in the `home/` directory of each module.

The script avoids replacing existing files / symlinks and will report on skipped or linked files. Manually remove files you want replaced.

## Module structure

Each module can have the following directories:

* `bashrc.d/`: scripts to be loaded when starting a new shell
* `bin/`: added to `$PATH` so that scripts are available
* `home/`: files to be symlinked in the user's home via the installation script

Additionally, modules can have OS-specific sub-directories so that scripts are conditionally only available to the current OS.

In some cases the order in which modules are loaded matters. Modules are loaded in alphabetical order, use prefixes to control the loading sequence.

Here is a sample module structure:

```
modules/<load-order>-<module-name>/
|-- bashrc.d
|   |-- # Scripts loaded unconditionally for a new shell
|   |-- darwin
|   |   `-- # Scripts loaded exclusively on OSX
|   `-- linux
|       `-- # Scripts loaded exclusively on Linux
|-- bin
|   |-- # Scripts made available with directory added to the $PATH
|   |-- darwin
|   |   `-- # Only added to the $PATH on OSX
|   `-- linux
|       `-- # Only added to the $PATH on Linux
`-- home
    `-- # Files or directories symlinked on the user's home on installation
```

## Testing

Tests use `bats` and are meant to run using docker.


```sh
# Run all tests
make test
# or
scripts/run-tests.sh

# Pass additional arguments to `bats`. (E.g. a specific test file)
scripts/run-tests.sh tests/test_integration.bats
```
