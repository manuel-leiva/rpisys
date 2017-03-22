#! /bin/bash

# Autotools package name
PKGNAME=$1
# Prefix string to be used in pc and la files
PREFIX=$2

# Change library la files
AUTOTOOLS_LA_LIBS=$(find ${PKGNAME} -name *.la)
echo AUTOTOOLS_LA_LIBS-num ${#AUTOTOOLS_LA_LIBS[@]}
if [ -n "${AUTOTOOLS_LA_LIBS}" ]; then
    for i in ${AUTOTOOLS_LA_LIBS}; do
        echo Lib $i ;
        sed -i "s:libdir=':libdir='${PREFIX}:g" $i ;
    done ;
fi

AUTOTOOLS_LAI_LIBS=$(find ${PKGNAME} -name *.lai)
if [ -n "${AUTOTOOLS_LAI_LIBS}" ]; then
    for i in ${AUTOTOOLS_LAI_LIBS}; do
        echo Lib $i ;
        sed -i "s:libdir=':libdir='${PREFIX}:g" $i ;
    done ;
fi

# Change library package config files
AUTOTOOLS_PC_FILES=$(find ${PKGNAME} -name *.pc)
if [ -n "${AUTOTOOLS_PC_FILES}" ]; then
    for i in ${AUTOTOOLS_PC_FILES}; do
        echo Files $i ;
        sed -i "s:^prefix=:prefix=${PREFIX}:g" $i ;
        sed -i "s:^libdir=:libdir=${PREFIX}:g" $i ;
        sed -i "s:^toolexeclibdir=:toolexeclibdir=${PREFIX}:g" $i ;
    done ;
fi
