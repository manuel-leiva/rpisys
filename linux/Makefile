
.PHONY: all clean header

# Include local definition
include ../board.defs
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef LINUX_JOBS_PER_EXE
# If LINUX_JOBS_PER_EXE is not defined LINUX_MAKE_JOBS=1
LINUX_MAKE_JOBS:=1
$(warning WARN: LINUX_JOBS_PER_EXE not defined)
endif

## Local definitions ##

LINUX_PATH:=${PRJ_ROOT_PATH}/linux
# Installation directories
LINUX_MOD_INSTALLDIR:=modules
LINUX_KERNEL_INSTALLDIR:=kernel
#
LINUX_MAKE_JOBS?=$(shell echo ${LINUX_JOBS_PER_EXE}*${HOST_CORES}/100 | bc )

# Create kernel compilation flags
KERNEL_FLAGS:=CROSS_COMPILE=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX) KERNEL=$(LINUX_KERNEL_EXTRAFLAGS)

# Instalation paths
LINUX_KERNEL_INSTALL_PATH:=$(LINUX_PATH)/$(LINUX_KERNEL_INSTALLDIR)
LINUX_MOD_INSTALL_PATH   :=$(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)

# Public targets ###############################################################

all: header linux-modules

header:
	@$(ECHO) "${MSG_INFO}Linux build${MSG_END}"

# Alias target to install linux
install: linux-install

uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall linux${MSG_END}"
	$(V) $(RM) linux-install

clean: header
	@$(ECHO) "${MSG_INFO}  Remove linux${MSG_END}"
	$(V) $(RM) linux-uncomp linux-build linux-install linux-patch linux-download linux-modules linux-built-script-post
# Remove Linux code
	$(V) $(RM) linux
# Remove linux modules
	$(V) $(RM) $(LINUX_MOD_INSTALL_PATH) $(LINUX_KERNEL_INSTALL_PATH)

help:
	@$(ECHO) ""

# Private targets ###############################################################

linux-download:
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name linux \
    --pkg-target-name ${LINUX_NAMETAR} \
    --dl-path ${PRJ_DOWNLOAD_PATH} \
    --dl-url ${LINUX_DLURL}
	$(V) touch $@

linux-patch: linux-download
	@    $(ECHO) "${MSG_INFO}  Apply linux patches ${MSG_END}"
	$(V) touch $@

linux-build: linux-patch
	@    $(ECHO) "${MSG_INFO}  Build linux ${MSG_END}"
	$(V) $(MAKE) linux $(KERNEL_FLAGS) $(LINUX_DEFCONFIG)
	$(V) $(MAKE) linux -j $(LINUX_MAKE_JOBS) $(KERNEL_FLAGS) zImage dtbs
# Install Kernel files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) linux/arch/arm/boot/zImage $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) linux/arch/arm/boot/dts/*.dtb $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/*.dtb* $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/README $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) touch $@

# linux-build-script-post: linux-build
# 1: Target name
# 2: dependencies list
# 3: Message
# 4: Script path
# 5: Variable that contains the script name
# 6: Script parameters
$(eval $(call COMMON_TARGET_SCRIPT,linux-build-script-post,linux-build,"build post script",${BOARD_SCRIPT_PATH},BOARD_LINUX_BUILD_SCRIPT_POST_NAME,--build-path $(LINUX_PATH) --pkg-dir-name $(BOARD_LINUX_PKG_DIR_NAME) --kernel-install-path $(LINUX_KERNEL_INSTALL_PATH) --module-install-path $(LINUX_MOD_INSTALL_PATH)))

linux-modules: linux-build-script-post
	@    $(ECHO) "${MSG_INFO}  Build linux modules ${MSG_END}"
	$(V) $(MAKE) linux -j $(LINUX_MAKE_JOBS) $(KERNEL_FLAGS) modules
# Install Kernel modules
	$(V) $(MKDIR) $(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
	$(V) $(MAKE) linux $(KERNEL_FLAGS) INSTALL_MOD_PATH=$(LINUX_MOD_INSTALL_PATH) modules_install
	$(V) touch $@

linux-install: linux-modules
	@$(ECHO) "${MSG_INFO}  Install linux${MSG_END}"
	@$(ECHO) "${MSG_INFO}    Install kernel${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/boot
	$(V) cd kernel; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/boot
	@$(ECHO) "${MSG_INFO}    Install modules${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/rootfs/
	$(V) cd modules; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs
	$(V) touch $@

linux-debug-var:
	@$(ECHO) LINUX_MAKE_JOBS: ${LINUX_MAKE_JOBS}

