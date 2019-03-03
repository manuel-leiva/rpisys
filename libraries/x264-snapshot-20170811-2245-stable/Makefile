

AUTOTOOLS_DL_URL := ftp://ftp.videolan.org/pub/videolan/x264/snapshots/

AUTOTOOLS_NAME_TAR := x264-snapshot-20170811-2245-stable.tar.bz2

AUTOTOOLS_SHA1SUM:=e9ddab79cbbea88b4b951cb922b2a32774599a3e

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) \
--enable-static --enable-shared --disable-opencl --disable-asm

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
