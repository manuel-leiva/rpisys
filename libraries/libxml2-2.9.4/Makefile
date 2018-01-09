

AUTOTOOLS_DL_URL := ftp://xmlsoft.org/libxml2/

AUTOTOOLS_NAME_TAR := libxml2-2.9.4.tar.gz

AUTOTOOLS_SHA1SUM:=958ae70baf186263a4bd801a81dd5d682aedd1db

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) \
--with-python=no

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
