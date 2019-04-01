#!/bin/bash
echo "Library links:"
ls -l /usr/local/lib/ | grep indy | tr -s ' ' | cut -d' ' -f 11

echo " "
echo "Dereferenced links:"
ls -lLh /usr/local/lib/ | egrep '(libindy|libnullpay|libvcx)'