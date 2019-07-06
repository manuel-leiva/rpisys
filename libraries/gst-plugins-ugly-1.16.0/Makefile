

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-plugins-ugly/

PACKAGE_NAME := gst-plugins-ugly-1.16.0.tar.xz

PACKAGE_SHA1SUM:=44aa8094282dbdbb993590498e448fb07b2e3123

PACKAGE_FLAGS += --prefix=/usr       \
       -Dbuildtype=release \

# Meson does apply these compiler parameters from pkg-config information
# TODO: Research this behavior
MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'
MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
