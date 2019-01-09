

AUTOTOOLS_DL_URL := https://cdn.kernel.org/pub/linux/utils/kernel/kmod/

AUTOTOOLS_NAME_TAR := kmod-25.tar.gz

AUTOTOOLS_SHA1SUM:=41737debfe2b98956bfb9ec3dfb502700a8f6a92

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST)

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
