

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gstreamer/

PACKAGE_NAME := gstreamer-1.16.0.tar.xz

PACKAGE_SHA1SUM:=c90c3bb6fae73412a75ab15dfc815ced1f410b2d

PACKAGE_FLAGS += --prefix=/usr       \
       -Dbuildtype=release \
       -Dgst_debug=false   \
       -Dgtk_doc=disabled  \

# PACKAGE_LIBRARY_INSTALLDIR
PACKAGE_LIBRARY_PREFIX=/usr

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
