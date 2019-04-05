#!/usr/bin/env bash
source $(dirname "$0")/reinstall.sh
echo "export PATH='$PATH:$target_dir'" >> "$HOME/.bashrc"

