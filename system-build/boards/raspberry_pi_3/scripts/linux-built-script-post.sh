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
        -b|--build-path)
        BUILD_PATH="$2"
        shift
        ;;
        -p|--pkg-dir-name)
        PKG_DIR_NAME="$2"
        shift
        ;;
        -m|--module-install-path)
        MOD_INSTALL_PATH="$2"
        shift
        ;;
        -k|--kernel-install-path)
        KERNEL_INSTALL_PATH="$2"
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

# Change owner
echo -e "Change image name and install"
cp ${BUILD_PATH}/${PKG_DIR_NAME}/arch/arm/boot/zImage ${KERNEL_INSTALL_PATH}/kernel7.img
