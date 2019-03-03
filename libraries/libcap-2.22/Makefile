

LIB_DL_URL := http://ftp.de.debian.org/debian/pool/main/libc/libcap2/

LIB_NAME_TAR := libcap2_2.22.orig.tar.gz

LIB_SHA1SUM:=7753165ca685a0c78735fa0db25b815d9576b1fe

LIB_CFLAGS += -I${PRJ_ROOT_PATH}/libraries/host-libraries/usr/include/arm-linux-gnueabihf

LIB_MAKE_INSTALL_FLAGS=RAISE_SETFCAP=no

# Build package using general library recipe
include ../../system-build/makefile/Makefile.lib
