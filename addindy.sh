#!/bin/bash

SOURCE="$1"
VERSION="$2"

if [ -z "$VERSION" ]; then
	echo "Version was not specified"
	exit -1
fi

if [ ! -f $SOURCE ]; then
   echo "Source $SOURCE is not a file."
fi

LIB_NAME=`basename $SOURCE`
if [[ "$SOURCE" =~ .*\.dylib ]]; then
    TARGET="/usr/local/lib/storage/indy/$VERSION-$LIB_NAME"
    cp "$SOURCE" "$TARGET"
else
    echo "Source file $SOURCE is not mac .dylib library."
    exit -1
fi



