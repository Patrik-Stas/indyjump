INDYJUMP_INDY="libindy"
INDYJUMP_VCX="libvcx"
INDYJUMP_NULLPAY="libnullpay"

errcho(){ >&2 echo $@; }

function exitWithErrMsg() {
  errcho "$1"
  exit 1
}

function validateLibName() {
  local LIBNAME="$1"
  case "$LIBNAME" in
     "$INDYJUMP_INDY")
       ;;
     "$INDYJUMP_VCX")
       ;;
     "$INDYJUMP_NULLPAY")
       ;;
     *)
       errcho "Got library name '${LIBNAME}' Valid names for libraries are: '$INDYJUMP_INDY' '$INDYJUMP_VCX' '$INDYJUMP_NULLPAY'"
       exit 1
       ;;
   esac
}

function getSysLibsPath() {
  echo "/usr/local/lib"
}

function getStoragePath() {
  local LIBSYSPATH=`getSysLibsPath` || exit 1
  echo "$LIBSYSPATH/indyjump"
}


function getPathForManagedBinary() {
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  local TAG="$2"
  if [ -z "$TAG" ]; then
     errcho "[error] getPathForManagedBinary >>> Function argument TAG was not passed."
     exit 1
  fi;
  local LIB_FILENAME=`getLibraryFilename $LIBNAME` || exit 1
  local STORAGE_DIR=`getStoragePath $LIBNAME` || exit 1
  echo "$STORAGE_DIR/$TAG-$LIB_FILENAME"
}


function getSymlinkPath() {
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  echo "`getSysLibsPath`/`getLibraryFilename $LIBNAME`"
}


function manageIndyjumpBinary() {
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  local srcPath="$2"

  if [ ! -f $srcPath ]; then
   errcho "[error] manageIndyjumpBinary >>> srcPath was set to '$srcPath'. No such file exists."
   exit 1
  fi

  destinationPath="$3"
  if [ -f $destinationPath ]; then
   echo "[warn] manageIndyjumpBinary >>> destinationPath was set to '$destinationPath'. This file will be rewritten!"
  fi
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
       errcho 'Unsupported OS.' 
       exit 1
       ;;
  esac
}

function getBasePath(){
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  if [ -z "$INDY_SDK_SRC" ]; then 
    errcho "getBasePath() >>> Exiting. Env variable 'INDY_SDK_SRC' is not set"
    exit 1
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
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

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
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  local basePath=`getBasePath "$LIBNAME"` || exit 1
  local libraryFilename=`getLibraryFilename "$LIBNAME"` || exit 1
  local buildPath="target/debug"
  echo "$basePath/$buildPath/$libraryFilename"
}