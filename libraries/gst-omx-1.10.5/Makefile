

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gst-omx/

AUTOTOOLS_NAME_TAR := gst-omx-1.10.5.tar.xz

AUTOTOOLS_SHA1SUM:=ef88cbfbeb18fc51f839dd0da1aa016338b34092

ifeq ($(MACHINE_NAME),Raspberry_Pi_3)
# Custom flags for Raspberry pi 3
AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) --with-omx-target=rpi CFLAGS=-I$(PRJ_ROOT_PATH)/filesystem/filesystem/opt/vc/include/IL/
else
AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) --with-omx-target=generic
endif

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
