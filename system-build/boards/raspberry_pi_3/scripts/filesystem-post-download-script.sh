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
        -p|--pwd)
        PWD="$2"
        shift
        ;;
        -b|--fs-dir)
        FS_DIR="$2"
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
echo -e "${MSGCOLOR}You need root permisions:${ENDCOLOR}"
sudo chown $USER:$USER ${PWD}/${FS_DIR}/etc/wpa_supplicant
sudo chown $USER:$USER ${PWD}/${FS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf
