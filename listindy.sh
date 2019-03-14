#!/bin/bash

ls -lah /usr/local/lib/storage/indy/* | tr -s " " | cut -d" "  -f9 | cut -d"/" -f7 | cut -d"-" -f1 | sort -u