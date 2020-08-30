source $(dirname "$0")/scripts/indyjump-utils.sh

ext=`getLibExtension`
echo "Your system is susing library extension '$ext'"


indyBase=`getBasePath "libindy"`
vcxBase=`getBasePath "libvcx"`
nullpayBase=`getBasePath "libnullpay"`
libindystrgpostgresBase=`getBasePath "libindystrgpostgres"`
echo "Indy base directory is '$indyBase'"
echo "Vcx base directory is '$vcxBase'"
echo "Nullpay base directory is '$nullpayBase'"
echo "pgwallet base directory is '$libindystrgpostgresBase'"


indyLibname=`getLibraryFilename "libindy"`
vcxLibname=`getLibraryFilename "libvcx"`
nullpayLibname=`getLibraryFilename "libnullpay"`
libindystrgpostgresLibname=`getLibraryFilename "libindystrgpostgres"`
echo "Indy library filename is '$indyLibname'"
echo "Vcx library filename is '$vcxLibname'"
echo "Nullpay library filename is '$nullpayLibname'"
echo "pgwallet library filename is '$libindystrgpostgresLibname'"


indyFullPath=`getFullPath "libindy"`
vcxFullPath=`getFullPath "libvcx"`
nullpayFullPath=`getFullPath "libnullpay"`
libindystrgpostgresFullPath=`getFullPath "libindystrgpostgres"`
echo "Indy library filename is '$indyFullPath'"
echo "Vcx library filename is '$vcxFullPath'"
echo "Nullpay library filename is '$nullpayFullPath'"
echo "pgwallet library filename is '$libindystrgpostgresFullPath'"


echo "User libraries are expected to be in `getSysLibsPath`"
echo "Storage for indy binaries will be `getStoragePath`"


indyManagedPath=`getPathForManagedBinary "libindy" "master"`
vcxManagedPath=`getPathForManagedBinary "libvcx" "master"`
nullpayManagedPath=`getPathForManagedBinary "libnullpay" "master"`
libindystrgpostgresManagedPath=`getPathForManagedBinary "libindystrgpostgres" "master"`

echo "indy Managed path for TAG 'master' is '$indyManagedPath'"
echo "vcx Managed path for TAG 'master' is '$vcxManagedPath'"
echo "nullpay Managed path for TAG 'master' is '$nullpayManagedPath'"
echo "pgwallet Managed path for TAG 'master' is '$libindystrgpostgresManagedPath'"


indySymlinkPath=`getSymlinkPath "libindy"`
vcxSymlinkPath=`getSymlinkPath "libvcx"`
nullpaySymlinkPath=`getSymlinkPath "libnullpay"`
libindystrgpostgresSymlinkPath=`getSymlinkPath "libindystrgpostgres"`

echo "indy indySymlinkPath is '$indySymlinkPath'"
echo "vcx vcxSymlinkPath is '$vcxSymlinkPath'"
echo "nullpay nullpaySymlinkPath is '$nullpaySymlinkPath'"
echo "pgwallet nullpaySymlinkPath is '$libindystrgpostgresSymlinkPath'"

getActiveProvisionName libindy
#echo "Active libindy provison is '$libindyActiveProvision'"
