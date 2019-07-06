
# # Meson
# PACKAGE_DL_URL := https://gstreamer.freedesktop.org/src/gst-omx/
# PACKAGE_NAME := gst-omx-1.16.0.tar.xz
# PACKAGE_SHA1SUM:=4a45a0e4c4be3de638aff7fcf9e5ae6c2bca74ab
# PACKAGE_FLAGS += --prefix=/usr \
#        -Dbuildtype=release \
#        -Dgtk_doc=disabled  \
#        -Dtarget=rpi
# # Meson does apply these compiler parameters from pkg-config information
# # TODO: Research this behavior
# MESON_CFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lgmodule-2.0','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/IL/','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vcos/pthreads','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vmcs_host/linux'
# MESON_LDFLAGS='-L${COMMON_LIB_BUILD_PATH}','-lpcre','-lffi','-lz','-lgmodule-2.0','-L$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/lib'
# MESON_CPPFLAGS='-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/IL/','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vcos/pthreads','-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vmcs_host/linux'
# PACKAGE_PKGCONFIG_PATH=$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/lib/pkgconfig
# # Build package using meson recipe
# include ../../system-build/makefile/Makefile.meson


## Autotools

AUTOTOOLS_DL_URL  := https://gstreamer.freedesktop.org/src/gst-omx/
AUTOTOOLS_NAME_TAR:= gst-omx-1.16.0.tar.xz
AUTOTOOLS_SHA1SUM :=4a45a0e4c4be3de638aff7fcf9e5ae6c2bca74ab

# TODO: MACHINE_NAME is not recognized
#ifeq ($(MACHINE_NAME),Raspberry_Pi_3)
## Custom flags for Raspberry pi 3
AUTOTOOLS_FLAGS+= --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) --with-omx-target=rpi \
  CFLAGS='-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/IL/ -L${COMMON_LIB_BUILD_PATH} -lffi -lpcre' \
  CPPFLAGS='-I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include -I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/IL -I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vcos/pthreads -I$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/include/interface/vmcs_host/linux -L${COMMON_LIB_BUILD_PATH} -lffi -lpcre' \
  LDFLAGS='-L${COMMON_LIB_BUILD_PATH} -lffi -lpcre'

AUTOTOOLS_PKGCONFIG_PATH=$(COMMON_LIB_HOST_LIB_PATH)/opt/vc/lib/pkgconfig
#else
#AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) --with-omx-target=generic
#endif

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools


