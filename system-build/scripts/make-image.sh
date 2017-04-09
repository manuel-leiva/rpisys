#!/bin/bash

# make-image is a script tool for creating booteable images
# Author: Manuel Leiva F. <manuelleivaf@gmail.com>

ERRORCOLOR="\033[1;31m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

# Partition name
BOOT_NAME="BOOT"
ROOTFS_NAME="rootfs"

function help
{
    echo "help"
    echo "-d, --device"
    echo "-f, --rootfs-path"
    echo "-b, --boot-path"
    echo "-h, --help"
}

while [ $# -gt 0 ]
do
    key="$1"
    case $key in
        -d|--device)
        DEVICE_FILE="$2"
        shift
        ;;
        -f|--rootfs-path)
        FS_PATH="$2"
        shift
        ;;
        -b|--boot-path)
        BOOT_PATH="$2"
        shift
        ;;
        -h|--help)
        help
        exit
        ;;
        *)
          echo -e "${ERRORCOLOR}Error:${ENDCOLOR} invalid option $1"
          exit
        ;;
    esac
    shift
done

# Check if the device was defined
if [ -z ${DEVICE_FILE} ]; then
   echo -e ${ERRORCOLOR}Error:${ENDCOLOR} device not defined
   exit
else
    # Check if the device is available
    if [ -t $(ls ${DEVICE_FILE}) ]; then
        echo -e ${ERRORCOLOR}Device ${DEVICE_FILE} not available.${ENDCOLOR}
        exit
    fi
fi
# Check if the filesystem path was defined
if [ -z ${FS_PATH} ]; then
   echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Filesystem source path not defined.
   exit
else
    # Check if the filesystem exists
    if [ ! -d ${FS_PATH} ]; then
       echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Filesystem does not exist.
       exit
    fi
fi
# Check if the boot path was defined
if [ -z ${BOOT_PATH} ]; then
   echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Boot source path not defined.
   exit
else
    # Check if the boot path exists
    if [ ! -d ${BOOT_PATH} ]; then
       echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Filesystem does not exist.
       exit
    fi
fi

if [ "$DEVICE_FILE" = "/dev/sda" ]; then
    echo -e ${ERRORCOLOR}Error:${ENDCOLOR}${DEVICE_FILE} is a PC partition.
    exit
fi

echo -e "${MSGCOLOR}Device \"${DEVICE_FILE}\" is going to be erased.${ENDCOLOR}"
echo -e "${MSGCOLOR}Do you want to continue? [y/N]${ENDCOLOR}"
read -n 1 -r
echo
if [[ $REPLY != [yY] ]]; then
   echo -e "${INFOCOLOR}Aborting installation${ENDCOLOR}"
   exit
    # do dangerous stuff
fi

echo -e "${MSGCOLOR}You need to be logged in as root to erase${ENDCOLOR}"
echo -e "${MSGCOLOR}${DEVICE_FILE} and install the image${ENDCOLOR}"
sudo echo

# Check if some partition is mounted
MOUNTED_PATHS=$(mount | grep ${DEVICE_FILE} | awk '{print $3 }')
if [ -n "${MOUNTED_PATHS}" ]; then
    echo -e "${INFOCOLOR}  Unmount:${ENDCOLOR}\n${MOUNTED_PATHS}"
    for path in ${MOUNTED_PATHS}; do
        sudo umount $path
    done
fi

sudo sfdisk $DEVICE_FILE << EOF
8192,63MiB,0x0C,*
137216,4GiB,,-
EOF

echo -e "${INFOCOLOR}  Creating BOOT partition${ENDCOLOR}\n"
umount ${DEVICE_FILE}p1
sudo mkfs.vfat -F 32 -n ${BOOT_NAME} ${DEVICE_FILE}p1
umount ${DEVICE_FILE}p2
echo -e "${INFOCOLOR}  Creating rootfs partition${ENDCOLOR}\n"
sudo mkfs.ext4 -L ${ROOTFS_NAME} ${DEVICE_FILE}p2

