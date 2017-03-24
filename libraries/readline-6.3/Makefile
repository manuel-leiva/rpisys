

AUTOTOOLS_DL_URL := ftp://ftp.gnu.org/gnu/readline/

AUTOTOOLS_NAME_TAR := readline-6.3.tar.gz

AUTOTOOLS_FLAGS = --prefix=/usr --libdir=/usr/lib/arm-linux-gnueabihf/ --host=arm

# Fix cross compilation problem
# https://lists.gnu.org/archive/html/bug-readline/2014-03/msg00052.html
export bash_cv_wcwidth_broken=no

# Build package using autotools recipe
include ../../system-build/Makefile.autotools



