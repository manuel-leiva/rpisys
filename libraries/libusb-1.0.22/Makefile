

AUTOTOOLS_DL_URL := https://managedway.dl.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.22/

AUTOTOOLS_NAME_TAR := libusb-1.0.22.tar.bz2

AUTOTOOLS_SHA1SUM:=10116aa265aac4273a0c894faa089370262ec0dc

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) --disable-udev

#  --enable-udev: use udev for device enumeration and hotplug support (recommended) [default=yes]



# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
