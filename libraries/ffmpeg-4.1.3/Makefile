

AUTOTOOLS_DL_URL := http://ffmpeg.org/releases/

AUTOTOOLS_NAME_TAR := ffmpeg-4.1.3.tar.xz

AUTOTOOLS_SHA1SUM:=1c99bfe0323477fc302baec4c825f2e49634c466

# Special Crosscompilation parameters
# https://trac.ffmpeg.org/wiki/CompilationGuide/RaspberryPi

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) \
            --cross-prefix=$(COMMON_PREFIX_CROSS_COMPILE) \
            --arch=armel --target-os=linux \
            --enable-cross-compile  \
            --enable-gpl         \
            --enable-version3    \
            --enable-nonfree     \
            --disable-static     \
            --enable-shared      \
            --disable-debug      \
            --enable-avresample
            #--enable-libx264 \
            #--enable-libass   \
            #--enable-libfdk-aac  \
            #--enable-libfreetype \
            #--enable-libmp3lame  \
            #--enable-libopus     \
            #--enable-libtheora   \
            #--enable-libvorbis   \
            #--enable-libvpx      \
            #--enable-libx265

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
