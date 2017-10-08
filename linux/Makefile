# Include board definition
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_LINUX_SHA1SUM
$(error ERROR: BOARD_LINUX_SHA1SUM not defined)
endif

## Local definitions ##

LINUX_PATH:=${PRJ_ROOT_PATH}/linux
# Installation directories
LINUX_MOD_INSTALLDIR:=modules
LINUX_KERNEL_INSTALLDIR:=kernel

# Create kernel compilation flags
KERNEL_FLAGS:=CROSS_COMPILE=$(BOARD_TOOLCHAIN_PATH)/$(BOARD_TOOLCHAIN_PREFIX) KERNEL=$(BOARD_LINUX_KERNEL_EXTRAFLAGS)

## Exported variables
# Linux instalation paths
export LINUX_KERNEL_INSTALL_PATH:=$(LINUX_PATH)/$(LINUX_KERNEL_INSTALLDIR)
export LINUX_MOD_INSTALL_PATH   :=$(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
# Destination directories
# Path to install kernel and device tree
export LINUX_BOOT_INSTALL_PATH:=$(COMMON_IMAGE_BOOT_PATH)
# Path to install root file system
export LINUX_ROOTFS_INSTALL_PATH:=$(COMMON_IMAGE_ROOTFS_PATH)


# Public targets ###############################################################
.PHONY: all clean header

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
    --pkg-target-name ${BOARD_LINUX_NAMETAR} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_LINUX_DL_URL} \
    --sha1sum ${BOARD_LINUX_SHA1SUM}
	$(V) touch $@

linux-patch: linux-download
	@    $(ECHO) "${MSG_INFO}  Apply linux patches ${MSG_END}"
	$(V) touch $@

linux-build: linux-patch
	@    $(ECHO) "${MSG_INFO}  Build linux ${MSG_END}"
	$(V) $(MAKE) linux $(KERNEL_FLAGS) $(BOARD_LINUX_DEFCONFIG)
	$(V) $(MAKE) linux -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) zImage dtbs
# Install Kernel files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) linux/arch/arm/boot/zImage $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) linux/arch/arm/boot/dts/*.dtb $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/*.dtb* $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/README $(LINUX_KERNEL_INSTALL_PATH)/overlays
	$(V) touch $@

linux-modules: linux-build
	@    $(ECHO) "${MSG_INFO}  Build linux modules ${MSG_END}"
	$(V) $(MAKE) linux -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) modules
# Install Kernel modules
	$(V) $(MKDIR) $(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
	$(V) $(MAKE) linux $(KERNEL_FLAGS) INSTALL_MOD_PATH=$(LINUX_MOD_INSTALL_PATH) modules_install
	$(V) touch $@

linux-install: linux-modules
	@$(ECHO) "${MSG_INFO}  Install linux${MSG_END}"
# Call pre-install recipe
	$(call COMMON_HOOK_RECIPE,$(LOCAL_BOARD_DIR)/board.hook,linux-install-pre)
# Install kernel image, device tree and overlays
	@$(ECHO) "${MSG_INFO}    Install kernel${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/boot
	$(V) cd kernel; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/boot
# Install kernel modules
	@$(ECHO) "${MSG_INFO}    Install modules${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/rootfs/
	$(V) cd modules; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs
# Call post-install recipe
	$(call COMMON_HOOK_RECIPE,$(LOCAL_BOARD_DIR)/board.hook,linux-install-post)
	$(V) touch $@

linux-debug-var:
	@$(ECHO) COMMON_MAKE_JOBS: ${COMMON_MAKE_JOBS}
	@$(ECHO) KERNEL_FLAGS: ${KERNEL_FLAGS}

linux-export-var:
	@$(ECHO) LINUX_KERNEL_INSTALL_PATH: ${LINUX_KERNEL_INSTALL_PATH}
	@$(ECHO) LINUX_MOD_INSTALL_PATH: ${LINUX_MOD_INSTALL_PATH}
	@$(ECHO) LINUX_BOOT_INSTALL_PATH: $(LINUX_BOOT_INSTALL_PATH)
	@$(ECHO) LINUX_ROOTFS_INSTALL_PATH: $(LINUX_ROOTFS_INSTALL_PATH)
