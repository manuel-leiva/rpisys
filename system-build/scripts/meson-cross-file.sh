#! /bin/bash

# Message color
ERRORCOLOR="\033[1;31m"
INFOCOLOR="\033[0;36m"
MSGCOLOR="\033[1;33m"
ENDCOLOR="\033[0m"

FILE=cross_file.txt

function help
{
    echo "help"
    echo "-s, --system             Operative system"
    echo "-f, --cpu-family         CPU family"
    echo "-p, --cpu                CPU Id"
    echo "-c, --endianess          CPU endianess"
    echo "-c, --c-args             GCC flags"
    echo "-l, --c-link-args        G++ flags."
    echo "-b, --binaries-prefix    Toolchain prefix."
    echo "-k, --pkg-config-prefix  Toolchain prefix."
    echo "-k, --prefix             Library installation directory prefix."
    echo "-k, --libdir             Library intallation directory."
    echo "-o, --output             Output directory."
    echo "-h, --help"
}

while [ $# -gt 1 ]
do
    key="$1"
    case $key in
        # Operative system
        -s|--system)
        SYSTEM="$2"
        shift
        ;;
        # CPU family
        -f|--cpu-family)
        CPU_FAMILY="$2"
        shift
        ;;
        # CPU Id
        -p|--cpu)
        CPU="$2"
        shift
        ;;
        # Library source path
        -e|--endianess)
        ENDIANESS="$2"
        shift
        ;;
        # Compiler C args
        -c|--c-args)
        C_ARGS="$2"
        shift
        ;;
        # Compiler C link args
        -l|--c-link-args)
        C_LINK_ARGS="$2"
        shift
        ;;
        # Toolchain tools prefix
        -b|--binaries-prefix)
        BINARIES_PREFIX="$2"
        shift
        ;;
        # Toolchain pkg-config prefix
        -b|--pkg-config-prefix)
        PKG_CONFIG_PREFIX="$2"
        shift
        ;;
        # Library prefix
        -b|--prefix)
        PATH_PREFIX="$2"
        shift
        ;;
        # Library directory
        -b|--libdir)
        PATH_LIBDIR="$2"
        shift
        ;;
        # Cross file directory output
        -o|--output)
        OUTPUT="$2"
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

# Check if the output was defined
if [ -z ${OUTPUT} ]; then
   echo -e "${ERRORCOLOR}Error:${ENDCOLOR} Option \"--output\" not defined."
   exit
else
    # Check if the filesystem exists
    if [ ! -d ${OUTPUT} ]; then
       echo -e "${ERRORCOLOR}Error:${ENDCOLOR} ${OUTPUT} does not exist."
       exit
    fi
fi


## Host machine information
echo "[host_machine]" > ${OUTPUT}/$FILE

if [ -z ${SYSTEM} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--system\" not defined."
else
    echo "system = '${SYSTEM}'" >> ${OUTPUT}/$FILE
fi

if [ -z ${CPU_FAMILY} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--cpu-family\" not defined."
else
    echo "cpu_family = '${CPU_FAMILY}'" >> ${OUTPUT}/$FILE
fi

if [ -z ${CPU} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--cpu\" not defined."
else
    echo "cpu = '${CPU}'" >> ${OUTPUT}/$FILE
fi

if [ -z ${ENDIANESS} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--endianess\" not defined."
else
    echo "endian = '${ENDIANESS}'" >> ${OUTPUT}/$FILE
fi

echo "" >> ${OUTPUT}/$FILE
## Compiler properties
echo "[properties]" >> ${OUTPUT}/$FILE

if [ -z ${C_ARGS} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--c_args\" not defined."
    echo "c_args = []" >> ${OUTPUT}/$FILE
else
    PYTHON_ARGS=$(echo ${C_ARGS} | sed  "s:,:',':g")
    echo "c_args = ['${PYTHON_ARGS}']" >> ${OUTPUT}/$FILE
fi

if [ -z ${C_LINK_ARGS} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--c-link-args\" not defined."
    echo "c_link_args = []" >> ${OUTPUT}/$FILE
else
    PYTHON_ARGS=$(echo ${C_LINK_ARGS} | sed  "s:,:',':g")
    echo "c_link_args = ['${PYTHON_ARGS}']" >> ${OUTPUT}/$FILE
fi

echo "" >> ${OUTPUT}/$FILE
## Toolchain tools
echo "[binaries]" >> ${OUTPUT}/$FILE

if [ -z ${BINARIES_PREFIX} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--binaries-prefix\" not defined."
else
    echo "c = '${BINARIES_PREFIX}gcc'" >> ${OUTPUT}/$FILE
    echo "cpp = '${BINARIES_PREFIX}g++'" >> ${OUTPUT}/$FILE
    echo "ar = '${BINARIES_PREFIX}ar'" >> ${OUTPUT}/$FILE
    echo "strip = '${BINARIES_PREFIX}strip'" >> ${OUTPUT}/$FILE

    if [ -z ${PKG_CONFIG_PREFIX} ]; then
        echo "pkgconfig = '/usr/bin/pkg-config'" >> ${OUTPUT}/$FILE
    else
        echo "pkgconfig = '${PKG_CONFIG_PREFIX}pkg-config'" >> ${OUTPUT}/$FILE
    fi
fi

echo "" >> ${OUTPUT}/$FILE
## Path
echo "[paths]" >> ${OUTPUT}/$FILE

if [ -z ${PATH_PREFIX} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--prefix\" not defined."
else
    echo "prefix = '${PATH_PREFIX}'" >> ${OUTPUT}/$FILE
fi

if [ -z ${PATH_LIBDIR} ]; then
    echo -e "${WARNCOLOR}Error:${ENDCOLOR} Option \"--libdir\" not defined."
else
    echo "libdir = '${PATH_LIBDIR}'" >> ${OUTPUT}/$FILE
fi
