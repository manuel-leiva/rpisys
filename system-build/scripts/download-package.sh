#!/bin/bash

# Package name
PKG_NAME=$1

PKG_TARGET_NAME=$2

DOWNLOAD_PATH=$3

DOWNLOAD_URL=$4


ERRORCOLOR="\033[1;31m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

# Download tarball package
function DownloadTar
{
    # Verify if the package was already downloaded
    if [ ! -f ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} ]; then
        echo -e "${INFOCOLOR}  Download ${PKG_NAME}${ENDCOLOR} "
        wget ${DOWNLOAD_URL}/${PKG_TARGET_NAME} -P ${DOWNLOAD_PATH}
    fi ;

    # Descompres Package
    # Check file owner
    OWNER=$(ls ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} -l | awk '{print $3 }')
    if [ "root" == ${OWNER} ]; then
        echo -e "${MSGCOLOR}You need to be logged in as root you to decompress ${PKG_TARGET_NAME}${ENDCOLOR}"
        sudo tar -xf ${DOWNLOAD_PATH}/${PKG_TARGET_NAME}
    else
        tar -xf ${DOWNLOAD_PATH}/${PKG_TARGET_NAME}
    fi
}

# Verify the type of target

case ${PKG_TARGET_NAME} in
    *.tar.gz)
        DownloadTar
        ;;

    *.git)
        # TODO
        echo -e "${ERRORCOLOR}ERROR: Target ${PKG_TARGET_NAME} is not supported${ENDCOLOR}"
        ;;
    *)

        echo -e "${ERRORCOLOR}ERROR: Target ${PKG_TARGET_NAME} is not supported${ENDCOLOR}"
        exit 1
esac





