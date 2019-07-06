# RPISYS project

RPISYS (**R**aspberry **Pi** **sys**tem) was created in order to build all
the packages required to create a bootable image for Raspberry Pi but now
it can be configured to create a bootable image for multiple target platforms.
The project is based on Makefiles and bash scripts and it simplifies and automates
the process of building a complete and bootable Linux environment for an embedded system
while using cross-compilation to allow building for multiple target platforms
on a single Linux-based development system.

The project contains a set of recipes and scripts
that perform generic tasks such build a kernel, compile libraries create an image etc,
therefore you can use these generic recipes to build different systems.

You can convert this generic task to a specific task through parameters
that are defined in a configuration file called machine definition.

Since there are some tasks where you need specific procedures that are not
covered by these generic recipes, The SDK allows adding hooks with customs
procedures that can be called before and after certain recipe.
Therefore all the specific configuration and specific procedures are used
by the SDK but also can be easily removed and replaced with a new configuration.

# Current configuration files

1.  Raspberry Pi 3
    *  Configuration file: raspberry_pi_3.defs
2.  Tegra X1/X2
    *  Configuration file: tegra_r28_1.defs

# Features

## Raspberry Pi 3

1.  Kernel: Kernel source tree for Raspberry Pi Foundation 4.14.89 (https://github.com/raspberrypi/linux)
2.  Filesystem: Rasbian Stretch Lite (2018-11-13) https://www.raspberrypi.org/downloads/raspbian/
3.  Toolchain: gcc-linaro-arm-linux-gnueabihf 6.1.1 (https://releases.linaro.org/components/toolchain/binaries/6.1-2016.08/)
4.  Libraries:
    *  glib 2.50.3
    *  gst-libav 1.10.5
    *  GStreamer 1.10.5 (plugins base, bad, good and ugly, gst-rtsp-server)
    *  Gst rpicamsrc 4fc608e (https://github.com/thaytan/gst-rpicamsrc/commit/4fc608eb8196f45c591263e5d50fd3057ac380e5)
    *  libffi 3.2.1
    *  libsoup 2.57.1
    *  libxml2 2.9.4
    *  ncurses 6.0
    *  pcre 8.40
    *  readline 6.3
    *  sqlite-autoconf 3170000
    *  x264 snapshot 2017-08-11 2245 stable
    *  zlib 1.2.11

3.  Image: SD bootable image.

## Tegra X1/X2

1.  Based on Linux For Tegra 28.1 (https://developer.nvidia.com/embedded/linux-tegra-archive)
2.  Jetpack installation is not required.
3.  Flash tools: Tegra186_Linux_R28.1.0_aarch64 (TX2), Tegra210_Linux_R28.1.0_aarch64 (TX1)
4.  Kernel: Kernel source tree for Tegra X1/X2 r28_Release_v1.0
5.  Filesystem: Tegra Linux Sample Root Filesystem R28.1.0 aarch64
6.  Toolchain: L4T gcc toolchain 64-bit v28.1
7.  Image:
    *  SD bootable image.
    *  EMMC image.

# Build project

1.Download project

```bash
git clone git@github.com:manuel-leiva/rpisys.git
```

## Raspberry Pi 3

2.Configure board

```bash
./configure --machine machine/raspberry_pi_3_stretch/raspberry_pi_3.defs
```

3.Build system
```bash
make
```

4.Create a bootable image

Insert a microSD memory and define the memory device in the board configuration. For example:
```
MACHINE_IMAGE_EXT_SD_DEVICE:=/dev/mmcblk0
```
Create SD image.
```bash
make image-sd
```

## Tegra X1/X2

By default, the configuration file create an image for Tegra X2, if you want to create an image for Tegra X1 you have to apply this change:

File: system-build/boards/tegra/tegra_r28_1.defs
```
- export MACHINE_NAME="Tegra_X2"
- # export MACHINE_NAME:="Tegra_X1"
+ # export MACHINE_NAME="Tegra_X2"
+ export MACHINE_NAME:="Tegra_X1"
```
2.  Configure board
```bash
./configure --machine machine/tegra/tegra_r28_1.defs
```
3.  Build system
```bash
make
```
4.  Create a bootable image
```bash
# Create EMMC image
make image-custom IMAGE=EMMC
# Create SD image
make image-sd
```

## Clean project

```bash
make clean
make machine-clean
./configure --clean
```

# Known issues
## The colors in the messages are not displayed.

In this case, apply this change:

system-build/makefile/Makefile.local:line 5:
```
- ECHO:=echo
+ ECHO:=echo -e
```
## If you see the character 'e' before each message.
Apply this change:

system-build/makefile/Makefile.local:line 5:
```
- ECHO:=echo -e
+ ECHO:=echo
```

# Development information

## Libraries

### How to add a new library based on autootools

1.Create a new directory with the name of the library in libraries directory. e.g.
```
#!bash
mkdir ${PRJ_ROOT_PATH}/libraries/libsoup-2.57.1/
```
2.Create Makefile
```
#!bash
touch ${PRJ_ROOT_PATH}/libraries/libsoup-2.57.1/Makefile
```
3.Define download URL, and autotools flags

#### Tarball
If the library is a tarball you have to specify the URL and tarball name
```
#!Makefile
AUTOTOOLS_DL_URL := http://ftp.gnome.org/pub/GNOME/sources/libsoup/2.57/
AUTOTOOLS_TAR_NAME := libsoup-2.57.1.tar.xz
AUTOTOOLS_SHA1SUM:=a855a98c1d002a4e2bfb7562135265a8df4dad65
AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(MACHINE_LIBRARY_MACHINE_INSTALLDIR) --host=$(MACHINE_LIBRARY_HOST)
```
#### Repository
If the library is in a repository tarball you have to specify the URL and repository name.
If AUTOTOOLS_BRANCH is not defined the default brach cloned is master.
```
#!Makefile
AUTOTOOLS_DL_URL := https://github.com/GNOME/
AUTOTOOLS_NAME_TAR := libsoup.git
AUTOTOOLS_BRANCH := gnome-3-30
```
4.Include Makefile. Since libsoup is an autotools project then Makefile.autotools file must be included
```
#!Makefile
# Build package using autotools recipe
include ../../system-build/makefile/Makefile.autotools
```
5.If the library has some dependency, define the list of dependency libraries in a file called dependency.txt
```
#!bash
touch ${PRJ_ROOT_PATH}/libraries/libsoup-2.57.1/dependency.txt
```
6.To compile the library as part of the system, add the library name into LIB_NAME_LIST defined in Make.defs
```
#!Makefile
MACHINE_LIBRARY_NAME_LIST := libsoup-2.57.1
```
Note: You can apply one or more patches. You have to create a directory called patches with a file called series where you can add the list of the patches (quilt aproach).

### How to add a new debian package

1.Create a new directory with the name of the library in libraries directory. e.g.
```
#!bash
mkdir ${PRJ_ROOT_PATH}/libraries/libbluetooth3_5.43-2/
```
2.Create Makefile
```
#!bash
touch ${PRJ_ROOT_PATH}/libraries/libbluetooth3_5.43-2/Makefile
```
3.Define download URL, debian package name and autotools flags
```
#!Makefile
DEB_DL_URL := https://archive.raspberrypi.org/debian/pool/main/b/bluez/
DEB_NAME_TAR := libbluetooth-dev_5.43-2+rpt2+deb9u2_armhf.deb
DEB_SHA1SUM:=ce051a39f12bb49fc02d5535f656013427560cc7
# Build package using debian recipe
include ../../system-build/makefile/Makefile.deb
```
4.Include Makefile. Makefile.deb file must be included
```
#!Makefile
# Build package using autotools recipe
include ../../system-build/makefile/Makefile.deb
```
5.If the library has some dependency, define the list of dependency libraries in a file called dependency.txt
```
#!bash
echo "libbluetooth3_5.43-2" > ${PRJ_ROOT_PATH}/libraries/libbluetooth-dev_5.43-2/dependency.txt
```
6.To compile the library as part of the system, add the library name into LIB_NAME_LIST defined in machine.defs
```
#!Makefile
MACHINE_LIBRARY_NAME_LIST := libbluetooth-dev_5.43-2
```

### How to cross-compile a new library from based on makefiles

1.Create a new directory with the name of the library in libraries directory. e.g.
```
#!bash
mkdir ${PRJ_ROOT_PATH}/libraries/libcap2_2.22
```
2.Create Makefile
```
#!bash
touch ${PRJ_ROOT_PATH}/libraries/libcap2_2.22/Makefile
```
3.Define download URL, package name and compilation flags
```
LIB_DL_URL := http://ftp.de.debian.org/debian/pool/main/libc/libcap2/
LIB_NAME_TAR := libcap2_2.22.orig.tar.gz
LIB_SHA1SUM:=7753165ca685a0c78735fa0db25b815d9576b1fe
LIB_CFLAGS += -I${PRJ_ROOT_PATH}/libraries/host-libraries/usr/include/arm-linux-gnueabihf
LIB_MAKE_INSTALL_FLAGS=RAISE_SETFCAP=no
```
4.Include Makefile. Makefile.deb file must be included
```
#!Makefile
# Build package using autotools recipe
include ../../system-build/makefile/Makefile.deb
```
5.If the library has some dependency, define the list of dependency libraries in a file called dependency.txt

6.To compile the library as part of the system, add the library name into LIB_NAME_LIST defined in machine.defs
```
#!Makefile
MACHINE_LIBRARY_NAME_LIST := libcap2_2.22
```

## Image

### Configuration

By default the filesystem is installed in $RPISYS/image/image/rootfs.
if you want to define a custom location you can define MACHINE_FILESYSTEM_INSTALLATION_PATH, in this case the installation path is $RPISYS/image/$MACHINE_FILESYSTEM_INSTALLATION_PATH.

By default the Bootloader Linux image and device tree is installed in $RPISYS/image/image/boot.
if you want to define a custom location you can define MACHINE_BOOTLOADER_INSTALLATION_PATH or MACHINE_LINUX_INSTALLATION_PATH, in this case the installation path is $RPISYS/image/$MACHINE_BOOTLOADER_INSTALLATION_PATH and $RPISYS/image/$MACHINE_LINUX_INSTALLATION_PATH.

If is defined a custom path for linux image, device tree, bootloader or  filesystem you have to define the partition path, For example:
```
#!Makefile
MACHINE_IMAGE_P0_PATH:=${MACHINE_BOOTLOADER_INSTALLATION_PATH}
MACHINE_IMAGE_P1_PATH:=${MACHINE_FILESYSTEM_INSTALLATION_PATH}
```

### Custom images

The target image-custom was defined to add a hook and make custom images configurations if it's required. e.g.
```bash
# Create EMMC image
make image-custom IMAGE=EMMC
```

### Backing up the partition table

The image partition file descriptor path is defined with MACHINE_IMAGE_DISK_PARTITION_PATH. e.g.
```bash
MACHINE_IMAGE_DISK_PARTITION_PATH=$(LOCAL_MACHINE_PATH)/rpi-stretch-partition-table.dump
```

You can create a SD image, define the partition structure using gparter,
sfdisk supports an option to save a description of the device layout to a text file unsing --dump.
The dump format is suitable for later RPISYS input. For example:

```!bash
sudo sfdisk --dump /dev/mmcblk0 > rpi-stretch-partition-table.dump
```

## Libraries

    *  attr-2.4.47
    *  blueZ-5.50 (http://www.bluez.org/)
    *  dbus-1.12.10
    *  expat-2.1.0
    *  glib 2.50.3
    *  gst-libav 1.10.5
    *  GStreamer 1.10.5 (plugins base, bad, good and ugly, gst-rtsp-server)
    *  Gst rpicamsrc 4fc608e (https://github.com/thaytan/gst-rpicamsrc/commit/4fc608eb8196f45c591263e5d50fd3057ac380e5)
    *  kmod-25
    *  libcap2-2.22
    *  libffi 3.2.1
    *  libsoup 2.57.1
    *  libusb-1.0.22
    *  libxml2 2.9.4
    *  ncurses 6.0
    *  pcre 8.40
    *  readline 6.3
    *  sqlite-autoconf 3170000
    *  util-linux-2.33
    *  x264 snapshot 2017-08-11 2245 stable
    *  xz-5.2.4 (https://tukaani.org/xz/)
    *  zlib 1.2.11

## Project directory description

*  machine: Machine definitions for platforms supported
*  toolchain: Build toolchain
*  linux: Build Linux kernel
*  filesystem: Build filesystem
*  Libraries: Build libraries and applications
*  image: Build image
*  system-build: Collection of recipes and scripts used to build the system

## Variables Naming

### Board Prefix description

*  MACHINE_PRJ_: Machine variables realated to the general project configuration.
*  MACHINE_TOOLCHAIN_: Machine toolchain configuration.
*  MACHINE_BOOTLOADER_: Machine bootloader configuration.
*  MACHINE_FILESYSTEM_: Machine filesystem configuration.
*  MACHINE_LINUX_: Machine Linux kernel configuration.
*  MACHINE_LIBRARY_: Machine filesystem libraries configuration.
*  MACHINE_IMAGE_: Machine image configuration.

### Modules Prefix

* MACHINE_: Variables specific for board configuration.
* BOOTLOADER_: Bootloader variables configuration.
* FILESYTEM_: Filesystem variables configuration.
* LIBRARIES_: Libraries variables configuration.
* LINUX_: Linux kernel variables configuration
* TOOLCHAIN_: Toolchain variables configuration.
* COMMON_: Common variables configuration
* COMMON_RECIPE_: Makefile common recipe
* COMMON_TARGET_: Makefile common target and recipe

### Sufix description

* _DL_URL: Download URL.
* _TAR_NAME: Tarball name.
* _SHA1SUM: SHA1SUM value for tarball file.
* _PKG_NAME: Package name after decompress the tarball or clone the repository.

