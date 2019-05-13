#! /bin/bash

# Message color
ERRORCOLOR="\033[1;31m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

SCRIPT_DIR=$(dirname "$0")

function help
{
    echo "help"
    echo "-f, --cpu-family         CPU family"
    echo "-p, --filesystem         Filesystem path"
    echo "-c, --packages           List of packages to install"
    echo "-h, --help"
}

while [ $# -gt 1 ]
do
    key="$1"
    case $key in
        # CPU family
        -c|--cpu-family)
        CPU_FAMILY="$2"
        shift
        ;;
        # CPU Id
        -f|--filesystem)
        FILE_SYSTEM_PATH="$2"
        shift
        ;;
        # List of packages
        -l|--packages)
        PACKAGES="$2"
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

# Define QEMU version
case $CPU_FAMILY in
    # ARM 32 bits
    armv7l)
    QEMU=qemu-arm-static
    ;;
    # ARM 64 bits
    aarch64)
    QEMU=qemu-aarch64-static
    ;;
    *)
      echo -e "${ERRORCOLOR}Error:${ENDCOLOR} invalid cpu not supported $CPU_FAMILY"
      exit -1
    ;;
esac

# Verify if the filesystem path exists
if [ ! -d ${FILE_SYSTEM_PATH}/usr/bin/ ]; then
    $(ECHO) "${ERRORCOLOR}ERROR:${MSG_END} the path ${FILE_SYSTEM_PATH}/usr/bin/ doesn't exist"
    exit -1
fi

# Install qemu to machine filesystem
QEMU_PATH=$(which ${QEMU})
sudo cp ${QEMU_PATH} ${FILE_SYSTEM_PATH}/usr/bin/

# Install script
sudo cp ${SCRIPT_DIR}/chroot-apt-get-install.sh ${FILE_SYSTEM_PATH}

# Install packages
cd ${FILE_SYSTEM_PATH}; sudo ./chroot-apt-get-install.sh ${PACKAGES}

# Remove qemu and installation script
sudo rm -rf \
    ${FILE_SYSTEM_PATH}/usr/bin/${QEMU} \
    ${FILE_SYSTEM_PATH}/chroot-apt-get-install.sh

