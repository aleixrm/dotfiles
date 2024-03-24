#!/bin/sh -e
sudo apt-get install ripgrep
sudo apt-get install fd-find
ln -s $(which fdfind) ~/.local/bin/fd
