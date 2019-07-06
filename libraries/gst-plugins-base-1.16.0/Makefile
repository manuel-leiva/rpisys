

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-plugins-base/
PACKAGE_NAME := gst-plugins-base-1.16.0.tar.xz
PACKAGE_SHA1SUM:=03d4284b39171139dac7a6b3fd54aff68ba23f78

PACKAGE_FLAGS += --prefix=/usr       \
       -Dbuildtype=release \
       -Dgtk_doc=disabled  \

# Meson does apply these compiler parameters from pkg-config information
# TODO: Research this behavior
MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lgmodule-2.0'
MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lgmodule-2.0'

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
