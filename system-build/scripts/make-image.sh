#!/bin/bash

# make-image is a script tool for creating booteable images
# Author: Manuel Leiva F. <manuelleivaf@gmail.com>

# Partition name
PARTITION_0_NAME="BOOT"
PARTITION_1_NAME="rootfs"
# Directory name
PARTITION_0_MOUNT_DIR="p0_mount_dir"
PARTITION_1_MOUNT_DIR="p1_mount_dir"
# Directory name
PARTITION_0_FORMAT="FAT32"
PARTITION_1_FORMAT="EXT4"
# Messages color
ERRORCOLOR="\033[1;31m"
WARNCOLOR="\033[0;33m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"
# Maximum number of partitions
PARTITION_MAX=2

PARTITION_NAME_LIST=("PARTITION_0_NAME" "PARTITION_1_NAME" "PARTITION_2_NAME")
PARTITION_LIST=("PARTITION_0" "PARTITION_1" "PARTITION_2")
PARTITION_MOUNT_DIR_LIST=("PARTITION_0_MOUNT_DIR" "PARTITION_1_MOUNT_DIR" "PARTITION_2_MOUNT_DIR")
PARTITION_PATH_LIST=("PARTITION_0_PATH" "PARTITION_1_PATH" "PARTITION_2_PATH")
PARTITION_FORMAT_LIST=("PARTITION_0_FORMAT" "PARTITION_1_FORMAT" "PARTITION_3_FORMAT")

# Functions ####################################################################

# Copy the source data into each partition.
function ImageCopyData
{
    echo -e "${INFOCOLOR}Coping partition information${ENDCOLOR}\n"
    for IDX in $(seq 0 $PARTITION_MAX )
    do
        # Check if the filesystem path was defined, if it is not defined,
        # no data is copied and this step is skipped
        if [ ! -z ${!PARTITION_PATH_LIST[$IDX]} ]; then
            # Check if the source exists
            if [ ! -d ${!PARTITION_PATH_LIST[$IDX]} ]; then
               echo -e ${ERRORCOLOR}Error:${ENDCOLOR} Directory ${!PARTITION_PATH_LIST[$IDX]} does not exist.
               exit
            else
                echo "  Partition: ${!PARTITION_LIST[$IDX]}"
                echo "  Name: ${!PARTITION_NAME_LIST[$IDX]}"
                echo "  Mount: ${!PARTITION_MOUNT_DIR_LIST[$IDX]}"
                echo "  Data: ${!PARTITION_PATH_LIST[$IDX]}"
                echo -e "${INFOCOLOR}Add ${PARTITION_1_PATH} content in ${PARTITION_1_NAME} partition${ENDCOLOR}."
                # Remove file if it exists previously
                rm -rf ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                # Create directory to mount partition
                mkdir ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                sudo mount ${!PARTITION_LIST[$IDX]} ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                case ${!PARTITION_FORMAT_LIST[$IDX]} in
                    "FAT32")
                        echo "  Format: FAT32"
                        sudo cp -r ${!PARTITION_PATH_LIST[$IDX]}/* ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                        ;;
                    "EXT4")
                        echo "  Format: EXT4"
                        sudo cp -a ${!PARTITION_PATH_LIST[$IDX]}/* ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                        ;;
                    *)
                        echo -e "${ERRORCOLOR}Error:${ENDCOLOR} unknown partition format ${!PARTITION_FORMAT_LIST[$IDX]}"
                        exit 1
                esac
                sudo umount ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
                rm -r ${!PARTITION_MOUNT_DIR_LIST[$IDX]}
            fi
        fi
    done
}

# Use a file usable as input to sfdisk to describe the partitions of a device.
function ImagePartitionFile
{
    echo -e "${INFOCOLOR}Creating partition${ENDCOLOR}\n"
    sudo sfdisk $DEVICE_FILE < $PARTITION_FILE
    # Update the kernel's information about the current status of disk partitions
    # asking it to re-read the partition table.
    sleep 2
    sudo partprobe $DEVICE_FILE
    # Get the format for each partition
    sed "s:=: :g" $PARTITION_FILE > partition_file
    sed -i "s:,: :g" partition_file
    FORMAT_LIST=$(awk '{print $8 }' partition_file)
    rm partition_file
    echo -e "${INFOCOLOR}Formating partition${ENDCOLOR}\n"
    # Convert FORMAT_LIST into an array
    FORMAT_LIST_ARRAY=($FORMAT_LIST)
    for IDX in $(seq 0 $PARTITION_MAX )
    do
        if [ -n "${FORMAT_LIST_ARRAY[$IDX]}" ]; then
            echo "  Partition: ${!PARTITION_LIST[$IDX]}"
            echo "  Name: ${!PARTITION_NAME_LIST[$IDX]}"
            case ${FORMAT_LIST_ARRAY[$IDX]} in
                c)
                    echo "  Format: FAT32 [${FORMAT_LIST_ARRAY[$IDX]}]"
                    # Save format detected
                    eval ${PARTITION_FORMAT_LIST[$IDX]}="FAT32"
                    sudo mkfs.vfat -F 32 -n ${!PARTITION_NAME_LIST[$IDX]} ${!PARTITION_LIST[$IDX]}
                    ;;
                83)
                    echo "  Format: EXT4 [${FORMAT_LIST_ARRAY[$IDX]}]"
                    # Save format detected
                    eval ${PARTITION_FORMAT_LIST[$IDX]}="EXT4"
                    sudo mkfs.ext4 -L ${!PARTITION_NAME_LIST[$IDX]} ${!PARTITION_LIST[$IDX]}
                    ;;
                *)
                    echo -e "${ERRORCOLOR}Error:${ENDCOLOR} unknown partition format ID ${FORMAT_LIST_ARRAY[$IDX]}"
                    exit 1
            esac
        fi
    done
}

# Use sfdisk to describe the partitions of a device.
function ImagePartitionDefault
{
    echo -e "${INFOCOLOR}Creating partition${ENDCOLOR}\n"
    {
        echo '8192,63MiB,0x0C,*'
        echo '137216,4GiB,,-'
    } | sudo sfdisk $DEVICE_FILE
    # Update the kernel's information about the current status of disk partitions
    # asking it to re-read the partition table.
    sleep 2
    sudo partprobe $DEVICE_FILE
    # Give format for each partition
    echo -e "${INFOCOLOR}  Creating BOOT partition: ${PARTITION_0}${ENDCOLOR}\n"
    sudo mkfs.vfat -F 32 -n ${PARTITION_0_NAME} ${PARTITION_0}
    echo -e "${INFOCOLOR}  Creating rootfs partition: ${PARTITION_1}${ENDCOLOR}\n"
    sudo mkfs.ext4 -L ${PARTITION_1_NAME} ${PARTITION_1}
}


function help
{
    echo "help"
    echo "-d, --device             Memory device"
    echo "-a, --partition0-path    Partition 0 information path"
    echo "-b, --partition1-path    Partition 1 information path"
    echo "-c, --partition2-path    Partition 2 information path"
    echo "-f, --partition-file     Describe the partitions of a device in a format that is usable as input to sfdisk."
    echo "-h, --help"
}

# Main #########################################################################

while [ $# -gt 0 ]
do
    key="$1"
    case $key in
        -d|--device)
        DEVICE_FILE="$2"
        shift
        ;;
        -b|--partition1-path)
        PARTITION_1_PATH="$2"
        shift
        ;;
        -a|--partition0-path)
        PARTITION_0_PATH="$2"
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
if [ -z ${PARTITION_FILE} ]; then
   echo -e ${WARNCOLOR}Warn:${ENDCOLOR} Partition file not defined
else
    # Check if the device is available
    if [ ! -f ${PARTITION_FILE} ]; then
        echo -e "${ERRORCOLOR}Error:${ENDCOLOR} File \"${PARTITION_FILE}\" does not exist. Using default configuration\n"
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
    # Unmount partitions
    for path in ${MOUNTED_PATHS}; do
        echo -e "${INFOCOLOR}  Unmount: ${path}${ENDCOLOR}"
        sudo umount $path
    done
fi

# Define partition name
PARTITION_0=${DEVICE_FILE}1;
PARTITION_1=${DEVICE_FILE}2;
if [ ! -b ${PARTITION_0} ]; then
    PARTITION_0=${DEVICE_FILE}p1
    PARTITION_1=${DEVICE_FILE}p2
fi


# Create partitions
# Check if a partition file was defined
if [ -z ${PARTITION_FILE} ]; then
    # Apply default partition
    ImagePartitionDefault
else
    ImagePartitionFile
fi
# Copy the data into each partition
ImageCopyData
