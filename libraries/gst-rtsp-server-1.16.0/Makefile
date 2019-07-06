

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-rtsp-server/
PACKAGE_NAME := gst-rtsp-server-1.16.0.tar.xz
PACKAGE_SHA1SUM:=cf536c3dec9b7a64d8a8c3aea3064a32b9a69bf9

PACKAGE_FLAGS += --prefix=/usr -Dbuildtype=release

# Meson does apply these compiler parameters from pkg-config information
# TODO: Research this behavior
MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'
MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
