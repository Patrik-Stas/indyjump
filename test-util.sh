source $(dirname "$0")/scripts/util.sh


ext=`getLibExtension`
echo "Your system is susing library extension '$ext'"

indyBase=`getBasePath "libindy"`
vcxBase=`getBasePath "libvcx"`
nullpayBase=`getBasePath "libnullpay"`
echo "Indy base directory is '$indyBase'"
echo "Vcx base directory is '$vcxBase'"
echo "Nullpay base directory is '$nullpayBase'"

indyLibname=`getLibraryFilename "libindy"`
vcxLibname=`getLibraryFilename "libvcx"`
nullpayLibname=`getLibraryFilename "libnullpay"`
echo "Indy library filename is '$indyLibname'"
echo "Vcx library filename is '$vcxLibname'"
echo "Nullpay library filename is '$nullpayLibname'"


indyFullPath=`getFullPath "libindy"`
vcxFullPath=`getFullPath "libvcx"`
nullpayFullPath=`getFullPath "libnullpay"`
echo "Indy library filename is '$indyFullPath'"
echo "Vcx library filename is '$vcxFullPath'"
echo "Nullpay library filename is '$nullpayFullPath'"