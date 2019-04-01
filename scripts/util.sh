INDYJUMP_INDY="libindy"
INDYJUMP_VCX="libvcx"
INDYJUMP_NULLPAY="libnullpay"


function getSysLibsPath() {
  echo "/usr/local/lib"
}

function getStoragePath() {
  echo "`getSysLibsPath`/indyjump"
}


function getPathForManagedBinary() {
  LIBNAME="$1"
  validateLibName "$LIBNAME"

  TAG="$2"
  if [ -z "$TAG" ]; then
     echo "[error] getPathForManagedBinary >>> Function argument TAG was not passed."
     exit -1
  fi;
  echo "`getStoragePath`/$TAG-`getLibraryFilename $LIBNAME`"
}


function getSymlinkPath() {
  LIBNAME="$1"
  validateLibName "$LIBNAME"
  echo "`getSysLibsPath`/`getLibraryFilename $LIBNAME`"
}


function manageIndyjumpBinary() {
  LIBNAME="$1"
  validateLibName "$LIBNAME"

  srcPath="$2"

  if [ ! -f $srcPath ]; then
   echo "[error] manageIndyjumpBinary >>> srcPath was set to '$srcPath'. No such file exists."
   exit -1
  fi

  destinationPath="$3"
  if [ -f $destinationPath ]; then
   echo "[warn] manageIndyjumpBinary >>> destinationPath was set to '$destinationPath'. This file will be rewritten!"
  fi



}

function validateLibName() {
  LIBNAME="$1"
  case "$LIBNAME" in
     "$INDYJUMP_INDY")
       ;;
     "$INDYJUMP_VCX")
       ;;
     "$INDYJUMP_NULLPAY")
       ;;
     *)
       echo "Got library name '${LIBNAME}' Valid names for libraries are: '$INDYJUMP_INDY' '$INDYJUMP_VCX' '$INDYJUMP_NULLPAY'"
       exit -1
       ;;
   esac
}

function getLibExtension() {
  case "$(uname -s)" in
     Darwin)
       echo 'dylib'
       return 0
       ;;
     Linux)
       echo 'so'
       return 0
       ;;
     *)
       echo 'Unsupported OS.' 
       exit -1
       ;;
  esac
}

function getBasePath(){
  LIBNAME="$1"
  validateLibName "$LIBNAME"

  if [ -z "$INDY_SDK_SRC" ]; then 
    echo "getBasePath() >>> Exiting. Env variable 'INDY_SDK_SRC' is not set"
    exit -1
  fi
  case "$LIBNAME" in
     "$INDYJUMP_INDY")
       echo "$INDY_SDK_SRC/libindy"
       ;;
     "$INDYJUMP_VCX")
       echo "$INDY_SDK_SRC/vcx/libvcx"
       ;;
     "$INDYJUMP_NULLPAY")
       echo "$INDY_SDK_SRC/libnullpay"
       ;;
  esac
}

function getLibraryFilename() {
  LIBNAME="$1"
  validateLibName "$LIBNAME"

  case "$LIBNAME" in
   "$INDYJUMP_INDY")
     echo "libindy.`getLibExtension`"
     ;;
   "$INDYJUMP_VCX")
     echo "libvcx.`getLibExtension`"
     ;;
   "$INDYJUMP_NULLPAY")
     echo "libnullpay.`getLibExtension`"
     ;;
   esac   
}


function getFullPath() {
  LIBNAME="$1"
  validateLibName "$LIBNAME"

  basePath=`getBasePath "$LIBNAME"`
  libraryFilename=`getLibraryFilename "$LIBNAME"`
  buildPath="target/debug"
  echo "$basePath/$buildPath/$libraryFilename"
}