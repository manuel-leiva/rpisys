#! /bin/bash


ERRORCOLOR="\033[1;31m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

function help
{
    echo "help"
}

while [ $# -gt 1 ]
do
    key="$1"
    case $key in
        # Autotools package name
        -p|--pkg-name)
        PKGNAME="$2"
        shift
        ;;
        # Prefix string to be used in pc and la files
        -f|--host-prefix)
        PREFIX="$2"
        shift
        ;;
        # Library directory for the normal user-programs installation
        -b|--libs-path)
        LIBS_INSTALLDIR="$2"
        shift
        ;;
        # Help
        -h|--help)
        help
        ;;
        *)
          echo -e "${ERRORCOLOR}Error:${ENDCOLOR} invalid option $1"
          exit
        ;;
    esac
    shift
done

INSTALL_DIR=install

# Change library la files
AUTOTOOLS_LA_LIBS=$(find ${INSTALL_DIR} -name *.la)
if [ -n "${AUTOTOOLS_LA_LIBS}" ]; then
    for i in ${AUTOTOOLS_LA_LIBS}; do
        echo Lib $i ;
        sed -i "s:^libdir=':libdir='${PREFIX}:g" $i ;
        # This command is to substitude the paths in the dependency_libs variable
        sed -i "s: ${LIBS_INSTALLDIR}: ${PREFIX}${LIBS_INSTALLDIR}:g" $i ;
    done ;
fi

# Change library package config files
AUTOTOOLS_PC_FILES=$(find ${INSTALL_DIR} -name *.pc)
if [ -n "${AUTOTOOLS_PC_FILES}" ]; then
    for i in ${AUTOTOOLS_PC_FILES}; do
        echo Files $i ;
        sed -i "s:^prefix=:prefix=${PREFIX}:g" $i ;
        sed -i "s:^libdir=:libdir=${PREFIX}:g" $i ;
        sed -i "s:^toolexeclibdir=:toolexeclibdir=${PREFIX}:g" $i ;
    done ;
fi
