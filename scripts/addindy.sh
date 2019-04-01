#!/bin/bash
source $(dirname "$0")/util.sh

LIBRARY="$1"
TAG="$2"

if [ -z "$LIBRARY" ]; then
	echo "Version was not specified"
	exit -1
fi

if [ ! -z "$TAG" ]; then
   echo "Source $SOURCE is not a file."
fi

LIB_PATH=`getFullPath $LIBRARY`

if [ ! -f "$LIB_PATH" ]; then
   echo "File $FILE does not exist."
   exit -1
else 
    TARGET="/usr/local/lib/storage/indy/$VERSION-$LIB_NAME"
	cp "$SOURCE" "$TARGET"
fi
