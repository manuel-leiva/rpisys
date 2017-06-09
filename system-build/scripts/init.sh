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
        -b|--board)
        BOARD="$2"
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

## Check parameters

if [ -z ${PWD} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--pwd\" not defined."
   exit
else
    # Check if the directory exists
    if [ ! -d ${PWD} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${PWD} does not exist."
       exit
    fi
fi


if [ -z ${BOARD} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--pwd\" not defined."
   exit
else
    # Check if the directory exists
    if [ ! -f ${PWD}/system-build/boards/${BOARD} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${BOARD} does not exist."
       exit
    fi
fi

# Init system

ln -s ${PWD}/system-build/boards/${BOARD} ${PWD}/board.defs

sed -i "s|PRJ_ROOT_PATH:=project_path|PRJ_ROOT_PATH=${PWD}|g" ${PWD}/system-build/makefile/Makefile.common
