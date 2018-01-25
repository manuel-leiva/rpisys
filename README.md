# RPISYS project

RPISYS (**R**aspberry **Pi** **sys**tem) was created in order to build all the packages required to create a bootable image for Raspberry Pi. The project is based on Makefiles and bash scripts.

The main goal of the project is to contain a set of recipes and scripts that perform generic tasks such build a kernel, compile libraries create an image etc, therefore you can use these generic recipes to build different systems. You can convert this generic task to a specific task through parameters that are defined in a configuration file that is called board definition.
Since there are some tasks where you need specific procedures that are not covered by these generic recipes, The SDK allows adding hooks with customs procedures that can be called before and after certain recipe.
Therefore all the specific configuration and specific procedures are used by the SDK but also can be easily removed and replaced with a new configuration.

# Configuration files

1.  Raspberry Pi 3
    *  Configuration file: raspberry_pi_3.defs
2.  Tegra X1/X2
    *  Configuration file: tegra_r28_1.defs

# Features

## Raspberry Pi 3

1.  Kernel: Kernel source tree for Raspberry Pi Foundation 4.4.50 (https://github.com/raspberrypi/linux)
2.  Filesystem: Rasbian Lite (2017-03-02) https://www.raspberrypi.org/downloads/raspbian/
3.  Toolchain: gcc-linaro-arm-linux-gnueabihf-raspbian 4.8.3 (https://github.com/raspberrypi/tools)
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

1.  Kernel: Kernel source tree for Tegra X1/X2 r28_Release_v1.0
2.  Filesystem: Tegra Linux Sample Root Filesystem R28.1.0 aarch64
3.  Toolchain: L4T gcc toolchain 64-bit v28.1
4.  Image:
    *  SD bootable image.
    *  EMMC image.

# Build project

1. Download project

```bash
git clone https://manuelleiva@bitbucket.org/manuelleiva/rpisys.git
```

## Raspberry Pi 3

2.  Configure board

```bash
./configure --board tegra/tegra_r28_1.defs
```

3.  Build system
```bash
make
```

4.  Create a bootable image
```bash
# Create SD image
make image-sd
```

## Tegra X1/X2

By default, the configuration file create an image for Tegra X2, if you want to create an image for Tegra X1 you have to apply this change:

File: system-build/boards/tegra/tegra_r28_1.defs
```
- export BOARD_NAME="Tegra_X2"
- # export BOARD_NAME:="Tegra_X1"
+ # export BOARD_NAME="Tegra_X2"
+ export BOARD_NAME:="Tegra_X1"
```
2.  Configure board
```bash
./configure --board tegra/tegra_r28_1.defs
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
make board-clean
./configure --clean
```

# Known issues
## Sometimes the colors in the messages are not displayed.

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

## Project directory description 

*  toolchain: Build toolchain
*  linux: Build Linux kernel
*  filesystem: Build filesystem
*  Libraries: Build libraries
*  image: Build image
*  system-build: Collection of recipes and scripts used to build the system

## Variables Naming

### Board Prefix description

*  BOARD_PRJ_: Board variables realated to the general project configuration.
*  BOARD_TOOLCHAIN_: Board toolchain configuration.
*  BOARD_BOOTLOADER_: Board bootloader configuration.
*  BOARD_FILESYSTEM_: Board filesystem configuration.
*  BOARD_LINUX_: Board Linux kernel configuration.
*  BOARD_LIBRARY_: Board filesystem libraries configuration.
*  BOARD_IMAGE_: Board image configuration.

### Modules Prefix

* BOARD_: Variables specific for board configuration.
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

## Libraries

### How to add a new library

1.Create a new directory with the name of the library at:
```
#!bash
mkdir ${PRJ_ROOT_PATH}/libraries/libsoup-2.57.1/
```
2.Create Makefile 
```
#!bash
touch ${PRJ_ROOT_PATH}/libraries/libsoup-2.57.1/Makefile
```
3.Define download URL, tarball name and autotools flags
```
#!Makefile
AUTOTOOLS_DL_URL := http://ftp.gnome.org/pub/GNOME/sources/libsoup/2.57/
AUTOTOOLS_TAR_NAME := libsoup-2.57.1.tar.xz
AUTOTOOLS_SHA1SUM:=a855a98c1d002a4e2bfb7562135265a8df4dad65
AUTOTOOLS_FLAGS += --prefix=/usr --libdir=$(BOARD_LIBRARY_BOARD_INSTALLDIR) --host=$(BOARD_LIBRARY_HOST)
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
BOARD_LIBRARY_NAME_LIST := libsoup-2.57.1
```
Note: You can apply one or more patches. You have to create a directory called patches with a file called series where you can add the list of the patches (quilt aproach). 

## Image

### Configuration

By default the filesystem is installed in $RPISYS/image/image/rootfs.
if you want to define a custom location you can define BOARD_FILESYSTEM_INSTALLATION_PATH, in this case the installation path is $RPISYS/image/$BOARD_FILESYSTEM_INSTALLATION_PATH.

By default the Bootloader Linux image and device tree is installed in $RPISYS/image/image/boot.
if you want to define a custom location you can define BOARD_BOOTLOADER_INSTALLATION_PATH or BOARD_LINUX_INSTALLATION_PATH, in this case the installation path is $RPISYS/image/$BOARD_BOOTLOADER_INSTALLATION_PATH and $RPISYS/image/$BOARD_LINUX_INSTALLATION_PATH.

If is defined a custom path for linux image, device tree, bootloader or  filesystem you have to define the partition path, For example:
```
#!Makefile
BOARD_IMAGE_P0_PATH:=${BOARD_BOOTLOADER_INSTALLATION_PATH}
BOARD_IMAGE_P1_PATH:=${BOARD_FILESYSTEM_INSTALLATION_PATH}
```

### Custom images

The target image-custom was defined to add a hook and make custom images configurations if it's required.

