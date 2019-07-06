

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-libav/

PACKAGE_NAME := gst-libav-1.16.0.tar.xz

PACKAGE_SHA1SUM:=d9e2c29ec1d64e81eceb1b0acb88dcd1c439d191

PACKAGE_FLAGS += --prefix=/usr       \
       -Dbuildtype=release \
       -Dwith-libav-extra-configure="--disable-yasm"

# Meson does apply these compiler parameters from pkg-config information
# TODO: Research this behavior
MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'
MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
