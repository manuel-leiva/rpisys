

PACKAGE_DL_URL := http://ftp.gnome.org/pub/GNOME/sources/glib/2.60/

PACKAGE_NAME := glib-2.60.0.tar.xz

PACKAGE_SHA1SUM:=9e3e1120086550ac0b17e16e4aaa0dfc0c9e9792

PACKAGE_FLAGS += -Dman=true  -Dselinux=disabled -Dlibmount=false

# PACKAGE_LIBRARY_INSTALLDIR
PACKAGE_LIBRARY_PREFIX=/usr

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
