#!/bin/bash

INDY_VERSION="$1"

LIBS="/usr/local/lib"
INDY_DYLIB="/usr/local/lib/storage/indy/$INDY_VERSION-libindy.dylib"     
VCX_DYLIB="/usr/local/lib/storage/indy/$INDY_VERSION-libvcx.dylib"     
NULLPLAY_DYLIB="/usr/local/lib//storage/indy/$INDY_VERSION-libnullpay.dylib"

if [ ! -f $INDY_DYLIB ]; then
   echo "Indy version $INDY_VERSION not found, because file '$INDY_DYLIB' does not exist."
fi

rm "$LIBS"/libindy.dylib 2>/dev/null || : 
rm "$LIBS"/libvcx.dylib  2>/dev/null || :
rm "$LIBS"/libnullpay.dylib  2>/dev/null || :

echo "What has been done:"
if [ -f $INDY_DYLIB ]; then
	ln -s "$INDY_DYLIB" "$LIBS"/libindy.dylib
	echo "Changed version for LibIndy"
fi

if [ -f $INDY_DYLIB ]; then
	ln -s "$VCX_DYLIB" "$LIBS"/libvcx.dylib
	echo "Changed version for LibVCX"
fi;

if [ -f $INDY_DYLIB ]; then
	ln -s "$NULLPLAY_DYLIB" "$LIBS"/libnullpay.dylib
	echo "Changed version for LibNullPay"
fi;