#!/bin/sh

NEOVIM_VER=0.9.5
PYTHON_VER=3.12.2

# Plugins -> asdf plugin add <plugin>

asdf plugin add neovim
asdf plugin add python

# Versions -> asdf install <name> <version> + set global with asdf global <name> <version>
asdf install neovim $NEOVIM_VER 
asdf global neovim $NEOVIM_VER

asdf install python $PYTHON_VER
asdf global  python $PYTHON_VER



