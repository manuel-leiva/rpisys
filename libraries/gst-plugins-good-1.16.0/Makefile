

PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-plugins-good/
PACKAGE_NAME := gst-plugins-good-1.16.0.tar.xz
PACKAGE_SHA1SUM:=541abbdfc627b3502e044ac1f29a5fb4ac2096c0

PACKAGE_FLAGS += --prefix=/usr       \
       -Dbuildtype=release \
       -Dgtk_doc=disabled  \
       -Daudiofx=disabled

# Meson does apply these compiler parameters from pkg-config information
# TODO: Research this behavior
MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'
MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lm','-lgmodule-2.0'

# Build package using meson recipe
include ../../system-build/makefile/Makefile.meson
