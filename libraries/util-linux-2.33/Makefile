

AUTOTOOLS_DL_URL := https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.33/

AUTOTOOLS_NAME_TAR := util-linux-2.33.tar.gz

AUTOTOOLS_SHA1SUM:=66ec72a350d50d05ae46f46285b82be01a784afa

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) --disable-makeinstall-chown

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
