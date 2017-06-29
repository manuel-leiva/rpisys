

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gstreamer/

AUTOTOOLS_NAME_TAR := gstreamer-1.10.5.tar.xz

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_ARCH)

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools

# The packages bison and flex are dependecy application of gstreamer
# that are used during the build process, therefore this applications
# must be installed in the PC:
#
# sudo apt-get install bison
# sudo apt-get install flex
