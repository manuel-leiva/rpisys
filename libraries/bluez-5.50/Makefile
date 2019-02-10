

AUTOTOOLS_DL_URL := http://www.kernel.org/pub/linux/bluetooth/

AUTOTOOLS_NAME_TAR := bluez-5.50.tar.xz

AUTOTOOLS_SHA1SUM:=a59289c91ccb7fac248e916838d4e66d7936151e

AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST) \
--enable-mesh=no --enable-client=no --enable-experimental --enable-maintainer-mode --with-systemdsystemunitdir=/lib/systemd/system --with-systemduserunitdir=/usr/lib/systemd

# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
