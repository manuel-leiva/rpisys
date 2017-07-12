# RPISYS project

# Directory description 

* toolchain: Build toolchain
* linux: Build Linux kernel
* filesystem: Build filesystem
* Libraries: Build libraries
* image: Build image
* system-build: Collection of recipes and scripts used to build the system

# Build project #

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
 ## Dependecies packages ##

```
#!bash
sudo apt-get install autoconf
sudo apt-get install libtool
sudo apt-get install quilt
```

# Libraries #

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
AUTOTOOLS_NAME_TAR := libsoup-2.57.1.tar.xz
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
LIB_NAME_LIST := libsoup-2.57.1
```