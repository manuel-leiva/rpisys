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

ifndef BOARD_PRJ_ARCH
$(error ERROR: BOARD_PRJ_ARCH not defined)
endif

ifndef BOARD_TOOLCHAIN_PATH
$(error ERROR: BOARD_TOOLCHAIN_PATH not defined)
endif

ifndef BOARD_TOOLCHAIN_PREFIX
$(error ERROR: BOARD_TOOLCHAIN_PREFIX not defined)
endif

ifndef BOARD_LINUX_DEFCONFIG
$(error ERROR: BOARD_LINUX_DEFCONFIG not defined)
endif

ifndef BOARD_LINUX_PKG_NAME
$(error ERROR: BOARD_LINUX_PKG_NAME not defined)
endif

## Local definitions ##


# Installation directories
LINUX_MOD_INSTALLDIR:=modules
LINUX_KERNEL_INSTALLDIR:=kernel

# Create kernel compilation flags
KERNEL_FLAGS:=CROSS_COMPILE=$(BOARD_TOOLCHAIN_PATH)/$(BOARD_TOOLCHAIN_PREFIX) $(BOARD_LINUX_KERNEL_EXTRAFLAGS) ARCH=$(BOARD_PRJ_ARCH)

# Define destination directories
# Install kernel in the boot directory by default
ifndef BOARD_LINUX_KERNEL_INSTALLATION_DIR
LINUX_KERNEL_INSTALLATION_PATH=${COMMON_IMAGE_BOOT_PATH}
else
LINUX_KERNEL_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(BOARD_LINUX_KERNEL_INSTALLATION_DIR)
endif
# Install kernel modules in the filesystem by default
ifndef BOARD_LINUX_MODULES_INSTALLATION_DIR
LINUX_MODULES_INSTALLATION_PATH=${COMMON_IMAGE_ROOTFS_PATH}
else
LINUX_MODULES_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(BOARD_LINUX_MODULES_INSTALLATION_DIR)
endif


## Exported variables
# Linux instalation paths
export LINUX_PATH:=${PRJ_ROOT_PATH}/linux
export LINUX_PKG_DIR_NAME:=$(BOARD_LINUX_PKG_NAME)
export LINUX_KERNEL_INSTALL_PATH:=$(LINUX_PATH)/$(LINUX_KERNEL_INSTALLDIR)
export LINUX_MOD_INSTALL_PATH   :=$(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
export LINUX_KERNEL_INSTALLATION_PATH
export LINUX_MODULES_INSTALLATION_PATH

# Public targets ###############################################################
.PHONY: all clean zimage modules dtbs install uninstall clean

all: linux-header linux-modules linux-dtbs

download: linux-header linux-download

menuconfig: linux-header linux-menuconfig

zimage: linux-header linux-zimage

image: linux-header linux-image

modules: linux-header linux-modules

dtbs: linux-header linux-dtbs

# Alias target to install linux
install: linux-header linux-install

uninstall: linux-header linux-uninstall

clean: linux-header linux-clean ## Remove linux

# Private targets ###############################################################

linux-header:
	@$(ECHO) "${MSG_INFO}Linux kernel${MSG_END}"

linux-clean: linux-revpatch
	@$(ECHO) "${MSG_INFO}  Remove linux${MSG_END}"
	$(V) $(RM) linux-download linux-patch linux-revpatch linux-config linux-menuconfig linux-zimage linux-modules linux-dtbs linux-install
# Remove Linux code
	$(V) $(RM) ${BOARD_LINUX_PKG_NAME}
# Remove linux modules
	$(V) $(RM) $(LINUX_MOD_INSTALL_PATH) $(LINUX_KERNEL_INSTALL_PATH)
# Remove linux patches
	$(call COMMON_RECIPE_RM_PATCH,$(LINUX_PATH))
# Call post-clean hook
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)


linux-download:
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name ${BOARD_LINUX_PKG_NAME} \
    --pkg-target-name ${BOARD_LINUX_TAR_NAME} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_LINUX_DL_URL} \
    --sha1sum ${BOARD_LINUX_SHA1SUM}
# Call post-download hook
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@


# linux-revpatch:
# Parameters: target_prefix, dependecies, package-path, message
$(eval $(call COMMON_TARGET_REVPATCH,linux,,${LINUX_PATH},${BOARD_LINUX_PKG_NAME}))

# linux-patch:
# Parameters: target_prefix, dependecies, package-path, message
$(eval $(call COMMON_TARGET_PATCH,linux,linux-download,${LINUX_PATH},${BOARD_LINUX_PKG_NAME}))

linux-config: linux-patch
	@    $(ECHO) "${MSG_INFO}  Configuration $(BOARD_LINUX_DEFCONFIG)${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} $(KERNEL_FLAGS) $(BOARD_LINUX_DEFCONFIG)
	$(V) touch $@

linux-menuconfig: linux-config
	@    $(ECHO) "${MSG_INFO}  Menuconfig $(BOARD_LINUX_DEFCONFIG)${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} $(KERNEL_FLAGS) menuconfig

linux-image: linux-config
	@    $(ECHO) "${MSG_INFO}  Build linux Image${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) Image
# Install Kernel files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) ${BOARD_LINUX_PKG_NAME}/arch/$(BOARD_PRJ_ARCH)/boot/Image $(LINUX_KERNEL_INSTALL_PATH)

linux-zimage: linux-image
	@    $(ECHO) "${MSG_INFO}  Build linux zImage${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) zImage
# Install Kernel files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) ${BOARD_LINUX_PKG_NAME}/arch/$(BOARD_PRJ_ARCH)/boot/zImage $(LINUX_KERNEL_INSTALL_PATH)

linux-dtbs: linux-config
	@    $(ECHO) "${MSG_INFO}  Build dtbs${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) dtbs
# Install device tree files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALL_PATH)
	$(V) $(CP) ${BOARD_LINUX_PKG_NAME}/arch/$(BOARD_PRJ_ARCH)/boot/dts/*.dtb $(LINUX_KERNEL_INSTALL_PATH)
# Call post-dtbs recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),linux-dtbs-post)


linux-modules: linux-zimage
	@    $(ECHO) "${MSG_INFO}  Build linux modules ${MSG_END}"
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} -j $(COMMON_MAKE_JOBS) $(KERNEL_FLAGS) modules
# Install Kernel modules
	$(V) $(MKDIR) $(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
	$(V) $(MAKE) ${BOARD_LINUX_PKG_NAME} $(KERNEL_FLAGS) INSTALL_MOD_PATH=$(LINUX_MOD_INSTALL_PATH) modules_install
	$(V) touch $@

linux-install: linux-modules linux-dtbs
	@$(ECHO) "${MSG_INFO}  Install linux${MSG_END}"
# Call pre-install recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),linux-install-pre)
# Install kernel image, device tree and overlays
	@$(ECHO) "${MSG_INFO}    Install kernel${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/boot
	$(V) cd kernel; find . | cpio -pdum ${LINUX_KERNEL_INSTALLATION_PATH}
# Install kernel modules
	@$(ECHO) "${MSG_INFO}    Install modules${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/rootfs/
	$(V) cd modules; find . | cpio -pdum ${LINUX_MODULES_INSTALLATION_PATH}
# Call post-install recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),linux-install-post)
	$(V) touch $@

linux-uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall linux${MSG_END}"
	$(V) $(RM) linux-install

linux-debug-var:
	@$(ECHO) COMMON_MAKE_JOBS: ${COMMON_MAKE_JOBS}
	@$(ECHO) KERNEL_FLAGS: ${KERNEL_FLAGS}

linux-export-var:
	@$(ECHO) LINUX_PKG_DIR_NAME: ${LINUX_PKG_DIR_NAME}
	@$(ECHO) LINUX_KERNEL_INSTALL_PATH: ${LINUX_KERNEL_INSTALL_PATH}
	@$(ECHO) LINUX_MOD_INSTALL_PATH: ${LINUX_MOD_INSTALL_PATH}
	@$(ECHO) LINUX_KERNEL_INSTALLATION_PATH: $(LINUX_KERNEL_INSTALLATION_PATH)
	@$(ECHO) LINUX_MODULES_INSTALLATION_PATH: $(LINUX_MODULES_INSTALLATION_PATH)
