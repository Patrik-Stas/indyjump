INDYJUMP_INDY="libindy"
INDYJUMP_VCX="libvcx"
INDYJUMP_NULLPAY="libnullpay"

function validateLibname() {
  libname="$1"
  case "$libname" in
     "$INDYJUMP_INDY")
       ;;
     "$INDYJUMP_VCX")
       ;;
     "$INDYJUMP_NULLPAY")
       ;;
     *)
       echo "Got library name '${libname}' Valid names for libraries are: '$INDYJUMP_INDY' '$INDYJUMP_VCX' '$INDYJUMP_NULLPAY'"
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
  libname="$1"
  validateLibname "$libname"

  if [ -z "$INDY_SDK_SRC" ]; then 
    echo "getBasePath() >>> Exiting. Env variable 'INDY_SDK_SRC' is not set"
    exit -1
  fi
  case "$libname" in
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
  libname="$1"
  validateLibname "$libname"

  case "$libname" in
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
  libname="$1"
  validateLibname "$libname"

  basePath=`getBasePath "$libname"`
  libraryFilename=`getLibraryFilename "$libname"`
  buildPath="target/debug"
  echo "$basePath/$buildPath/$libraryFilename"
}