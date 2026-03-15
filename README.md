# Vim Configuration

This repository contains my personal Vim configuration.

## Directory layout

vimfiles/
├── vimrc
├── autoload/
├── colors/
├── syntax/
├── coc-settings.json
└── .gitignore

Important: the real configuration file is `vimrc` inside this repository.

## Windows setup

Vim on Windows loads the configuration from:

C:\Users\<username>\_vimrc

That file should contain only:

source ~/vimfiles/vimrc

This allows the actual configuration to live inside this Git repository.

## Plugins

Plugins are managed using vim-plug.

Install plugins with:

:PlugInstall

The plugin directory `plugged/` is intentionally ignored by Git.

## Ignored directories

The following directories are not tracked:

- plugged/ (downloaded plugins)
- undo/ (persistent undo history)
- .netrwhist (netrw history)

## Setup on a new machine

1. Clone the repository:

   git clone <repo-url> %USERPROFILE%\vimfiles

2. Create `_vimrc` in the home directory:

   source ~/vimfiles/vimrc

3. Start Vim and install plugins:

   :PlugInstall
