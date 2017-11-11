# RPISYS project

# Directory description 

* toolchain: Build toolchain
* linux: Build Linux kernel
* filesystem: Build filesystem
* Libraries: Build libraries
* image: Build image
* system-build: Collection of recipes and scripts used to build the system

# Build project

Apply configuration for a specific board.
```
#!bash
./configure --board raspberry_pi_3/raspberry_pi_3.defs
```
Build system
```
#!bash
make
```
 ## Dependecies packages

```
#!bash
sudo apt-get install autoconf
sudo apt-get install libtool
sudo apt-get install quilt
```

## Clean project

```
#!bash
make clean
make board-clean
./configure --clean
```
# Board configuration

## Variables Naming

### Board Sufix description

* BOARD_PRJ_: Board variables realated to the general project configuration.
* BOARD_TOOLCHAIN_: Board toolchain configuration.
* BOARD_BOOTLOADER_: Board bootloader configuration.
* BOARD_FILESYSTEM_: Board filesystem configuration.
* BOARD_LINUX_: Board Linux kernel configuration.
* BOARD_LIBRARY_: Board filesystem libraries configuration.
* BOARD_IMAGE_: Board image configuration.

### Modules sufix

* BOARD_: Variables specific for board configuration.
* BOOTLOADER_: Bootloader variables configuration.
* FILESYTEM_: Filesystem variables configuration.
* LIBRARIES_: Libraries variables configuration.
* LINUX_: Linux kernel variables configuration
* TOOLCHAIN_: Toolchain variables configuration.
* COMMON_: Common variables configuration
* COMMON_RECIPE_: Makefile common recipe
* COMMON_TARGET_: Makefile common target and recipe

### Prefix description

* _DL_URL: Download URL.
* _TAR_NAME: Tarball name.
* _SHA1SUM: SHA1SUM value for tarball file.
* _PKG_NAME: Package name after decompress the tarball or clone the repository.

# Libraries

## How to add a new library

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
AUTOTOOLS_FLAGS += --prefix=/usr --libdir=/usr/lib/arm-linux-gnueabihf/ --host=arm
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