

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gstreamer/

AUTOTOOLS_NAME_TAR := gstreamer-1.10.5.tar.xz

AUTOTOOLS_SHA1SUM:=acaf187b71692f98a2bafe8cac043a6df0a1b954

AUTOTOOLS_FLAGS += --build=x86_64-linux-gnu --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) \
--disable-gtk-doc --disable-failing-tests --disable-tests \
--disable-examples --disable-benchmarks --disable-debug

# The parameter have been added in order to avoid the error:
# warning: libgstbase-1.0.so.0, needed by ../../libs/gst/net/.libs/libgstnet-1.0.so, not found (try using -rpath or -rpath-link)
# ../../libs/gst/net/.libs/libgstnet-1.0.so: undefined reference to `gst_byte_writer_init_with_data'
#
# see: https://bugzilla.gnome.org/show_bug.cgi?id=770623#c22

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools

# The packages bison and flex are dependecy application of gstreamer
# that are used during the build process, therefore this applications
# must be installed in the PC:
#
# sudo apt-get install bison
# sudo apt-get install flex
