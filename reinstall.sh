#!/usr/bin/env bash

target_dir="$HOME/.indyjump"
echo "Updating scripts in indyjump directory $target_dir"

rm -r "$target_dir" || :
mkdir -p "$target_dir"
cp -r "./scripts/"* "$target_dir"
echo "Installed scripts:"
ls -lah "$target_dir"

