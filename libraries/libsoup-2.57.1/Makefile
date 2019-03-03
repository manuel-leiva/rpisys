

AUTOTOOLS_DL_URL := http://ftp.gnome.org/pub/GNOME/sources/libsoup/2.57/

AUTOTOOLS_NAME_TAR := libsoup-2.57.1.tar.xz

AUTOTOOLS_SHA1SUM:=a855a98c1d002a4e2bfb7562135265a8df4dad65

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST)

# If this meesage is show during the configuration:
# checking for intltool >= 0.35.0...  found
# The update intltool
# sudo apt-get install intltool

# Making all in libsoup
# /bin/bash: glib-mkenums: command not found


# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
