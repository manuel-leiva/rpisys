

AUTOTOOLS_DL_URL := https://gstreamer.freedesktop.org/src/gst-plugins-bad/

AUTOTOOLS_NAME_TAR := gst-plugins-bad-1.10.5.tar.xz

AUTOTOOLS_SHA1SUM:=6c5134e9b1bcf78e5ffae01ce140849c55dd8721

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) \
		--disable-dash --with-libgcrypt-prefix=$(AUTOTOOLS_PATH)

# Dash has been disable in order to avoid this error
# /home/mleiva/rpisys/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/../lib/gcc/arm-linux-gnueabihf/4.8.3/../../../../arm-linux-gnueabihf/bin/ld: warning: libgsturidownloader-1.0.so.0, needed by ../../gst-libs/gst/adaptivedemux/.libs/libgstadaptivedemux-1.0.so, not found (try using -rpath or -rpath-link)
# collect2: error: ld returned 1 exit status
# Makefile:2308: recipe for target 'elements/dash_demux' failed



# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
