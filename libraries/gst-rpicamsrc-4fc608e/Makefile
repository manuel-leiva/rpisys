
# https://github.com/thaytan/gst-rpicamsrc
AUTOTOOLS_DL_URL := https://www.dropbox.com/s/v989ilbz8uy8627/

AUTOTOOLS_NAME_TAR := gst-rpicamsrc-4fc608e.tar.gz

AUTOTOOLS_SHA1SUM:=487bfc6b22d278dfc1a776f8e802021939408a4e

AUTOTOOLS_FLAGS = --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) \
with_rpi_header_dir=$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/  \
LDFLAGS="-L$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/lib -L${COMMON_LIB_BUILD_PATH} -lpcre" CFLAGS=-Wl,-rpath-link=$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/lib

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
