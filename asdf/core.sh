#!/usr/bin/sh

# check if git is installed
if ! command -v git 2>&1 >/dev/null; then
    echo >&2 "Git dependency not installed, installing it..."
    sudo apt-get install git
fi

# check if curl is installed
if ! command -v curl 2>&1 >/dev/null; then
    echo >&2 "Curl dependency not installed, installing it..."
    sudo apt-get install curl
fi

# installing asdf
if command -v asdf 2>&1 >/dev/null; then
    echo >&2 "Asdf is already installed, skipping installation..."
    return 0
fi

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
echo 'asdf successfully installed in ~/.asdf'
echo 'Remember to source the $HOME/asdf/asdf.sh in your shell script, or enable "asdf" plugin in .zshrc file'
