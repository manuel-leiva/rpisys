

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gst-libav/

AUTOTOOLS_NAME_TAR := gst-libav-1.10.5.tar.xz

AUTOTOOLS_SHA1SUM:=49f513ceff110e7b02c9e3ed7927071cd29171fd

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) --with-libav-extra-configure=--ranlib=${CROSS_COMPILE}ranlib

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
