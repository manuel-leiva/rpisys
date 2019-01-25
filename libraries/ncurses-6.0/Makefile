

AUTOTOOLS_DL_URL := ftp://ftp.gnu.org/gnu/ncurses/

AUTOTOOLS_NAME_TAR := ncurses-6.0.tar.gz

AUTOTOOLS_SHA1SUM:=acd606135a5124905da770803c05f1f20dd3b21c

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST) CPPFLAGS="-P"

# Add CPPFLAGS="-P" to avoid compilation error
# https://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
