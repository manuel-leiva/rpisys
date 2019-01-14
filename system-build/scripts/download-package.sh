#!/bin/bash

# download-package is a script tool to download software packages
# Author: Manuel Leiva F. <manuelleivaf@gmail.com>

# Message color
ERRORCOLOR="\033[1;31m"
WARNCOLOR="\033[0;33m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

function help
{
    echo "help"
}

# By default don't use super user permission
SUPER_USER="n"
# Default destination path
DESTINATION_PATH="./"

while [ $# -gt 1 ]
do
    key="$1"
    case $key in
        # Autotools package name
        -p|--pkg-name)
        PKG_NAME="$2"
        shift
        ;;
        # Verifies SHA-1 hashes.
        -h|--sha1sum)
        SHA1SUM="$2"
        shift
        ;;
        # Package name
        -t|--pkg-target-name)
        PKG_TARGET_NAME="$2"
        shift
        ;;
        # Download destination path
        -d|--dl-path)
        DOWNLOAD_PATH="$2"
        shift
        ;;
        # Download URL
        -u|--dl-url)
        DOWNLOAD_URL="$2"
        shift
        ;;
        # Repository branch
        -b|--branch)
        BRANCH="$2"
        shift
        ;;
        # Repository depth
        --git-depth)
        GIT_DEPTH="$2"
        shift
        ;;
        -o|--dest)
        DESTINATION_PATH="$2"
        shift
        ;;
        # Use super user during decompress process (optional)
        -s|--su)
        SUPER_USER="$2"
        shift
        ;;
        # Define architecture
        -a|--arch)
        ARCHITECTURE="$2"
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

# Verify if the file is a tarball
function TarVerify
{
    FileDownload

    OUT=$(tar -tzf ${DOWNLOAD_PATH}/${PKG_TARGET_NAME})

    if [  -n "$OUT" ]; then
        return 0
    fi
    return 1

}

# Download package
function FileDownload
{
    # Verify if the package was already downloaded
    if [ ! -f ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} ]; then
        echo -e "${INFOCOLOR}  Download ${PKG_TARGET_NAME}${ENDCOLOR}"
        wget ${DOWNLOAD_URL}${PKG_TARGET_NAME} -P ${DOWNLOAD_PATH}
    fi ;
    # Check hash
    if [ ! -z ${SHA1SUM} ]; then
        PKG_TARGET_NAME_SHA1SUM=$(sha1sum ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} | grep -w ${SHA1SUM} )
        if [ x"${PKG_TARGET_NAME_SHA1SUM}" = x ]; then
            echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${PKG_TARGET_NAME} is corrupted"
            exit 1
        fi
    else
        echo -e "${WARNCOLOR}Warn:${ENDCOLOR} ${PKG_TARGET_NAME} is not verified"
    fi
}

function TarDecompress
{
    # Create destination path
    mkdir -p ${DESTINATION_PATH}
    # Check file owner
    OWNER=$(ls ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} -l | awk '{print $3 }')
    echo -e "${INFOCOLOR}  Decompress ${PKG_TARGET_NAME}${ENDCOLOR}"
    if [ "root" == ${OWNER} ]  || [ "y" == ${SUPER_USER} ] ; then
        echo -e "${MSGCOLOR}You need super user permissions to decompress ${PKG_TARGET_NAME}${ENDCOLOR}"
        # Decompress Package
        sudo \
        tar -xpf ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} -C ${DESTINATION_PATH}
    else
        # Decompress Package
        tar -xf ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} -C ${DESTINATION_PATH}
    fi
}

function DebDecompress
{
    if [ -z ${ARCHITECTURE} ]; then
        echo -e "${ERRORCOLOR}Error:${ENDCOLOR} System architecture not defined"
    else
        # Check if the debian package architecture matches
        ARCH=$( dpkg -I ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} | grep Architecture | awk '{print $2}' )
        if [ "$ARCHITECTURE" = "$ARCH" ]; then
            dpkg -x ${DOWNLOAD_PATH}/${PKG_TARGET_NAME} ${DESTINATION_PATH}
        else
            echo -e "${ERRORCOLOR}Error:${ENDCOLOR} package architecture ($ARCH) does not match system ($ARCHITECTURE)"
            exit 1
        fi
    fi
}

# Process tarball package
function TarProcess
{
    FileDownload
    TarDecompress
}

# Download Git repository
function GitProcess
{
    # If the branch is not defined, clone master branch
    if [ -z ${BRANCH} ]; then
        BRANCH=master
    fi
    GIT_CLONE_PARAMETERS="-b ${BRANCH} "
    if [ ! -z ${GIT_DEPTH} ]; then
        GIT_CLONE_PARAMETERS+="--depth=${GIT_DEPTH} "
    fi
    GIT_CLONE_PARAMETERS+=${DOWNLOAD_URL}${PKG_TARGET_NAME}
    # Clone repository
    git clone ${GIT_CLONE_PARAMETERS}
}

# Download Debian package
function DebianProcess
{
    FileDownload
    DebDecompress
}

# Verify the type of target
if [ ! -z ${PKG_TARGET_NAME} ]; then
    case ${PKG_TARGET_NAME} in
        *.tar.*) # tar command recognizes the format by itself
            TarProcess
            ;;
        *.tbz2) # tar command recognizes the format by itself
            TarProcess
            ;;
        *.git)
            # Clone GIT repository
            GitProcess
            ;;
         *.deb)
            # Download Debian package
            DebianProcess
            ;;
        *)
            echo -e "${WARNCOLOR}WARN: Target ${PKG_TARGET_NAME} format is not identified${ENDCOLOR}"
            echo -e "${INFOCOLOR}  Check if ${PKG_TARGET_NAME} is a tarball${ENDCOLOR}"
            TarVerify
            if [ $? -eq 0 ] ; then
                TarProcess
                exit 0
            fi
            echo -e "${ERRORCOLOR}ERROR: Target ${PKG_TARGET_NAME} is not supported${ENDCOLOR}"
            exit 1
    esac
fi





