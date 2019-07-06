

AUTOTOOLS_DL_URL := https://downloads.sourceforge.net/freetype/

AUTOTOOLS_NAME_TAR := freetype-2.10.0.tar.bz2

AUTOTOOLS_SHA1SUM:=f6abf03e0e3189a0de883981c57d3861b5d314f5

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) \
                   --enable-freetype-config --disable-static

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
