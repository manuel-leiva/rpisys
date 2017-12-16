#!/bin/bash

# make-image is a script tool for creating booteable images
# Author: Manuel Leiva F. <manuelleivaf@gmail.com>

# Partition name
BOOT_NAME="BOOT"
ROOTFS_NAME="rootfs"
# Directory name
MOUNT_BOOT_DIR="mount-boot"
MOUNT_ROOTFS_DIR="mount-rootfs"
# Messages color
ERRORCOLOR="\033[1;31m"
WARNCOLOR="\033[0;33m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"


function ImagePartitionFile
{
   sfdisk $DEVICE_FILE < $PARTITION_FILE

}
function ImagePartitionDefault
{
    {
        echo '8192,63MiB,0x0C,*'
        echo '137216,4GiB,,-'
    } | sudo sfdisk $DEVICE_FILE
    # Update the kernel's information about the current status of disk partitions
    # asking it to re-read the partition table.
    sleep 2
    sudo partprobe $DEVICE_FILE
    # Give format for each partition
    echo -e "${INFOCOLOR}  Creating BOOT partition: ${PARTITION_BOOT}${ENDCOLOR}\n"
    sudo mkfs.vfat -F 32 -n ${BOOT_NAME} ${PARTITION_BOOT}
    echo -e "${INFOCOLOR}  Creating rootfs partition: ${PARTITION_ROOTFS}${ENDCOLOR}\n"
    sudo mkfs.ext4 -L ${ROOTFS_NAME} ${PARTITION_ROOTFS}
}


function help
{
    echo "help"
    echo "-d, --device             Memory device"
    echo "-a, --partition0-path    Partition 0 information path"
    echo "-b, --partition1-path    Partition 1 information path"
    echo "-c, --partition2-path    Partition 2 information path"
    echo "-f, --partition-file     Describe the partitions of a device in a format that  is  usable  as input  to  sfdisk."
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
        -b|--partition1-path)
        FS_PATH="$2"
        shift
        ;;
        -a|--partition0-path)
        BOOT_PATH="$2"
        shift
        ;;
        -f|--partition-file)
        PARTITION_FILE="$2"
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
    if [ ! -e ${DEVICE_FILE} ]; then
        echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Device \"${DEVICE_FILE}\" does not exist.\n"
        exit
    fi
fi

# Check if the device was defined
if [ ! -z ${PARTITION_FILE} ]; then
   echo -e ${WARNCOLOR}Warn:${ENDCOLOR} Partition file not defined
else
    # Check if the device is available
    if [ ! -a ${PARTITION_FILE} ]; then
        echo -e "${ERRORCOLOR}Error:${ENDCOLOR} File \"${PARTITION_FILE}\" does not exist.\n"
    fi
fi


if [ "$DEVICE_FILE" = "/dev/sda" ]; then
    echo -e "${ERRORCOLOR}Error: ${ENDCOLOR}\"${DEVICE_FILE}\" is a PC driver.\n"
    exit
fi

echo -e "${MSGCOLOR}Device \"${DEVICE_FILE}\" is going to be erased.${ENDCOLOR}"
echo -e "${MSGCOLOR}Do you want to continue? [y/N]${ENDCOLOR}"
read -n 1 -r
echo
if [[ $REPLY != [yY] ]]; then
   echo -e "${INFOCOLOR}Aborting installation${ENDCOLOR}"
   exit
fi

echo -e "${MSGCOLOR}You need to be logged in as root to erase${ENDCOLOR}"
echo -e "${MSGCOLOR}${DEVICE_FILE} and install the image${ENDCOLOR}"
sudo echo

# Check if some partition is mounted
MOUNTED_PATHS=$(mount | grep ${DEVICE_FILE} | awk '{print $3 }')
if [ -n "${MOUNTED_PATHS}" ]; then
    for path in ${MOUNTED_PATHS}; do
        echo -e "${INFOCOLOR}  Unmount: ${path}${ENDCOLOR}"
        sudo umount $path
    done
fi

# Define partition name
PARTITION_BOOT=${DEVICE_FILE}1;
PARTITION_ROOTFS=${DEVICE_FILE}2;
if [ ! -b ${PARTITION_BOOT} ]; then
    PARTITION_BOOT=${DEVICE_FILE}p1
    PARTITION_ROOTFS=${DEVICE_FILE}p2
fi

echo -e "${INFOCOLOR}  Defining partition${ENDCOLOR}\n"
# Create partitions
# Check if a partition file was defined
if [ -z ${PARTITION_FILE} ]; then
    # Apply default partition
    ImagePartitionDefault
else
    ImagePartitionFile
fi

# Check if the boot path was defined, if it is not defined,
# no data is copied and this step is skipped
if [ -z ${BOOT_PATH} ]; then
   echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Boot source path not defined.
else
    # Check if the boot path exists
    if [ ! -d ${BOOT_PATH} ]; then
        echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Directory does not exist.
        exit
    else
        echo -e "${INFOCOLOR}Add ${BOOT_PATH} content in ${BOOT_NAME} partition ${ENDCOLOR}."
        # Remove file if it exists previously
        rm -rf ${MOUNT_BOOT_DIR}
        # Create directory to mount partitions
        mkdir ${MOUNT_BOOT_DIR}
        sudo mount ${PARTITION_BOOT} ${MOUNT_BOOT_DIR}
        sudo cp -r ${BOOT_PATH}/* ${MOUNT_BOOT_DIR}
        sudo umount ${MOUNT_BOOT_DIR}
        rm -r ${MOUNT_BOOT_DIR}
    fi
fi

# Check if the filesystem path was defined, if it is not defined,
# no data is copied and this step is skipped
if [ -z ${FS_PATH} ]; then
   echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Filesystem source path not defined.
else
    # Check if the filesystem exists
    if [ ! -d ${FS_PATH} ]; then
       echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Directory does not exist.
       exit
    else
        echo -e "${INFOCOLOR}Add ${FS_PATH} content in ${ROOTFS_NAME} partition${ENDCOLOR}."
        # Remove file if it exists previously
        rm -rf ${MOUNT_ROOTFS_DIR}
        # Create directory to mount partition
        mkdir ${MOUNT_ROOTFS_DIR}
        sudo mount ${PARTITION_ROOTFS} ${MOUNT_ROOTFS_DIR}
        sudo cp -a ${FS_PATH}/* ${MOUNT_ROOTFS_DIR}
        sudo umount ${MOUNT_ROOTFS_DIR}
        rm -r ${MOUNT_ROOTFS_DIR}
    fi
fi

