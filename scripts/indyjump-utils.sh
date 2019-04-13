#!/usr/bin/env bash
# INDYJUMPSCRIPT

INDYJUMP_INDY="libindy"
INDYJUMP_VCX="libvcx"
INDYJUMP_NULLPAY="libnullpay"

errcho(){ >&2 echo ">> ERROR: $@"; }

function magentaEcho() {
    local text="$1"
    echo -en "\033[1;95m$text\033[0m"
}

function greenEcho() {
    local text="$1"
    echo -en "\033[1;32m$text\033[0m"
}


function exitWithErrMsg() {
  errcho "$1"
  exit 1
}

function listAvailableProvisions() {
  ls  "`getStoragePath`/"* | tr -s " " | awk -F"/" '{print $NF}' | awk -F"-" '{print $1}' | uniq
}

function getLibrariesForProvision() {
  local PROVISION_TAG="$1"
  validateProvisionName "$PROVISION_TAG"
  ls "`getStoragePath`/"* | tr -s " " | awk -F"/" '{print $NF}' | grep "$PROVISION_TAG" | awk -F"-" '{print $2}' | awk -F"." '{print $1}' | tr '\r\n' ' '
}


function isLibraryUnderProvision() {
  local LIBRARY="$1"
  validateLibName "$LIBRARY" || exit 1
  local PROVISION_TAG="$2"
  local LIBRARY_FILE_PATH=`getPathForManagedBinary "$LIBRARY" "$PROVISION_TAG"`
  if [ ! -f "$LIBRARY_FILE_PATH" ]; then
     echo "false"
  else
    echo "true"
  fi;
}

function getProvisionLibraryPathIfExists() {
  local LIBRARY="$1"
  validateLibName "$LIBRARY" || exit 1
  local PROVISION_TAG="$2"
  validateProvisionName "$PROVISION_TAG"
  local LIBRARY_FILE_PATH=`getPathForManagedBinary "$LIBRARY" "$PROVISION_TAG"`
  if [ ! -f "$LIBRARY_FILE_PATH" ]; then
    exitWithErrMsg "Library $LIBRARY doesn't exists in provision $PROVISION_TAG"
  fi;
  echo $LIBRARY_FILE_PATH
}

function validatePathIsCargoProject() {
    SRC_BASE_PATH="$1"
    if [ ! -f "$SRC_BASE_PATH/Cargo.toml" ]; then
   	    exitWithErrMsg "Rust project file Cargo.toml was not found in directory $SRC_BASE_PATH"
   	fi;
}

function validateProvisionName() {
    local PROVISION_TAG="$1"
    if [ -z "$PROVISION_TAG" ]; then
        exitWithErrMsg  "You have to specify provision tag."
    fi
    if [[ "$PROVISION_TAG" =~ .*-.* ]]; then
        exitWithErrMsg  "Provision name '${PROVISION_TAG}' is invalid. Dash character (-) is not allowed in provision name."
    fi
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
       exitWithErrMsg "Got library name '${LIBNAME}' Valid names for libraries are: '$INDYJUMP_INDY' '$INDYJUMP_VCX' '$INDYJUMP_NULLPAY'"
       ;;
   esac
}

function getActiveProvisionName() {
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1
  ls -l `getSysLibsPath` | grep -v ^d | grep indyjump | grep "$LIBNAME"| grep -o -e "->.*" | awk -F"/" '{print $NF}' |  awk -F"-" '{print $1}'
}

function getSysLibsPath() {
  case "$(uname -s)" in
     Darwin)
       echo "/usr/local/lib"
       return 0
       ;;
     Linux)
       echo "/usr/lib"
       return 0
       ;;
     *)
       exitWithErrMsg 'Unsupported OS.'
       ;;
  esac
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
   exitWithErrMsg "[error] manageIndyjumpBinary >>> srcPath was set to '$srcPath'. No such file exists."
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
       exitWithErrMsg 'Unsupported OS.'
       ;;
  esac
}

function getBasePath(){
  local LIBNAME="$1"
  validateLibName "$LIBNAME" || exit 1

  if [ -z "$INDY_SDK_SRC" ]; then
    exitWithErrMsg "getBasePath() >>> Exiting. Env variable 'INDY_SDK_SRC' is not set"
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