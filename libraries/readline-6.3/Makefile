

AUTOTOOLS_DL_URL := ftp://ftp.gnu.org/gnu/readline/

AUTOTOOLS_NAME_TAR := readline-6.3.tar.gz

AUTOTOOLS_FLAGS = --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST)

AUTOTOOLS_SHA1SUM:=017b92dc7fd4e636a2b5c9265a77ccc05798c9e1

# Fix cross compilation problem
# https://lists.gnu.org/archive/html/bug-readline/2014-03/msg00052.html
export bash_cv_wcwidth_broken=no

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
