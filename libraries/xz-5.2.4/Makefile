
AUTOTOOLS_DESCRIPTION="XZ Utils is free general-purpose data compression software with a high compression ratio"

AUTOTOOLS_DL_URL := https://tukaani.org/xz/

AUTOTOOLS_NAME_TAR := xz-5.2.4.tar.bz2

AUTOTOOLS_SHA1SUM:=50ad451279404fb5206e23c7b1ba9c4aa858c994

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST)

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
