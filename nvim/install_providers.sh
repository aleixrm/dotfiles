#!/bin/sh -e

if ! command -v python3 2>&1 > /dev/null || ! command -v pip3 2>&1 > /dev/null; then
    echo >&2 "Python provider requires python3 and pip3 to be installed"
    exit 1
fi

echo "Installing pynvim python provider..."
python3 -m pip install --user --upgrade pynvim

