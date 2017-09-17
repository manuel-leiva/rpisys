
# https://github.com/thaytan/gst-rpicamsrc
AUTOTOOLS_DL_URL := https://www.dropbox.com/s/v989ilbz8uy8627/

AUTOTOOLS_NAME_TAR := gst-rpicamsrc-4fc608e.tar.gz

AUTOTOOLS_SHA1SUM:=487bfc6b22d278dfc1a776f8e802021939408a4e

AUTOTOOLS_FLAGS = --build=x86_64-linux-gnu --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) \
with_rpi_header_dir=$(PRJ_ROOT_PATH)/filesystem/filesystem/opt/vc/include  \
LDFLAGS=-L$(PRJ_ROOT_PATH)/filesystem/filesystem/opt/vc/lib CFLAGS=-Wl,-rpath-link=$(PRJ_ROOT_PATH)/filesystem/filesystem/opt/vc/lib

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
