#!/usr/bin/env bash

echo "Installing indyjump scripts to /usr/local/bin"
cp $(dirname "$0")"/scripts/"* "/usr/local/bin"
if [ $? -eq 0 ]; then
    echo "Installed"
else
    echo "Failed copying IndyJump scripts to /usr/local/bin"
fi


