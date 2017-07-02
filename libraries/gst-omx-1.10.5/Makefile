

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gst-omx/

AUTOTOOLS_NAME_TAR := gst-omx-1.10.5.tar.xz

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) --with-omx-target=rpi CFLAGS=I$(PRJ_ROOT_PATH)/filesystem/filesystem/opt/vc/include/IL/OMX_Broadcom.h

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
