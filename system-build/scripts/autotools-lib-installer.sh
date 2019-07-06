#! /bin/bash

# Message color
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
        # Library source path
        -b|--libsrc-path)
        LIBSRC_PATH="$2"
        shift
        ;;
        # Host library destination
        -b|--hostdest-path)
        HOSTDEST_PATH="$2"
        shift
        ;;
        # Build library destination
        -b|--boarddest-path)
        MACHINEDEST_PATH="$2"
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

## Check parameters

# Check if the filesystem path was defined
if [ -z ${LIBSRC_PATH} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--libsrc-path\" not defined."
   exit
else
    # Check if the filesystem exists
    if [ ! -d ${LIBSRC_PATH} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${LIBSRC_PATH} does not exist."
       exit
    fi
fi

# Check if the filesystem path was defined
if [ -z ${MACHINEDEST_PATH} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--boarddest-path\" not defined."
   exit
else
    # Check if the filesystem exists
    if [ ! -d ${MACHINEDEST_PATH} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${MACHINEDEST_PATH} does not exist."
       exit
    fi
fi

# Check if the filesystem path was defined
if [ -z ${HOSTDEST_PATH} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--hostdest-path\" not defined."
   exit
else
    # Check if the filesystem exists
    if [ ! -d ${HOSTDEST_PATH} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${HOSTDEST_PATH} does not exist."
       exit
    fi
fi

## Copy libraries

# Copy original directory into board destination directory
cp -a ${LIBSRC_PATH}/* ${MACHINEDEST_PATH}/

# Change library la files
AUTOTOOLS_LA_LIBS=$(find ${LIBSRC_PATH} -name *.la)
if [ -n "${AUTOTOOLS_LA_LIBS}" ]; then
    for i in ${AUTOTOOLS_LA_LIBS}; do
        sed -i "s:^libdir=':libdir='${PREFIX}:g" $i ;
        # This command is to substitude the paths in the dependency_libs variable
        sed -i "s: ${LIBS_INSTALLDIR}: ${PREFIX}${LIBS_INSTALLDIR}:g" $i ;
    done ;
fi

# Change library package config files
AUTOTOOLS_PC_FILES=$(find ${LIBSRC_PATH} -name *.pc)
if [ -n "${AUTOTOOLS_PC_FILES}" ]; then
    for i in ${AUTOTOOLS_PC_FILES}; do
        sed -i "s:^prefix=:prefix=${PREFIX}:g" $i ;
        # Check if the libdir has prefix
        CHECK_PREFIX=$( grep ^libdir $i | grep prefix )
        # if there not prefix
        if [ -z "$CHECK_PREFIX" ]; then
            sed -i "s:^libdir=:libdir=${PREFIX}:g" $i ;
        fi
        sed -i "s:^toolexeclibdir=:toolexeclibdir=${PREFIX}:g" $i ;
        # Check if the includedir has prefix or libdir
        CHECK_PREFIX=$( grep ^includedir $i | grep -e prefix -e libdir )
        # if there not prefix
        if [ -z "$CHECK_PREFIX" ]; then
            sed -i "s:^includedir=:includedir=${PREFIX}:g" $i ;
        fi
    done ;
fi

# Copy edited libraries into host destination directory
cp -a ${LIBSRC_PATH}/* ${HOSTDEST_PATH}/
