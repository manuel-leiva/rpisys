#! /bin/bash

# Autotools package name
PKGNAME=$1
# Prefix string to be used in pc and la files
PREFIX=$2
# Library directory for the normal user-programs installation
LIBS_INSTALLDIR=$3

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
