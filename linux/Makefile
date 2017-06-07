

.PHONY: all clean header

# Include local definition
include ../board.defs
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Local definitions

LINUX_PATH:=${PRJ_ROOT_PATH}/linux

# Create kernel compilation flags
KERNEL_FLAGS:=CROSS_COMPILE=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX) KERNEL=$(LINUX_KERNEL_EXTRAFLAGS)

# Instalation paths
LINUX_KERNEL_INSTALLPATH:=$(LINUX_PATH)/$(LINUX_KERNEL_INSTALLDIR)
LINUX_MOD_INSTALLPATH   :=$(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)

all: header linux-install

header:
	@$(ECHO) "${MSG_INFO}Linux build${MSG_END} "

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
	$(V) $(MAKE) linux -j $(LINUX_PAR_EXE) $(KERNEL_FLAGS) zImage dtbs
# Install Kernel files
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALLPATH)
	$(V) linux/scripts/mkknlimg linux/arch/arm/boot/zImage $(LINUX_KERNEL_INSTALLPATH)/kernel.img
	$(V) $(CP) linux/arch/arm/boot/dts/*.dtb $(LINUX_KERNEL_INSTALLPATH)
	$(V) $(MKDIR) $(LINUX_KERNEL_INSTALLPATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/*.dtb* $(LINUX_KERNEL_INSTALLPATH)/overlays
	$(V) $(CP) linux/arch/arm/boot/dts/overlays/README $(LINUX_KERNEL_INSTALLPATH)/overlays
	$(V) touch $@

linux-modules: linux-build
	@    $(ECHO) "${MSG_INFO}  Build linux modules ${MSG_END}"
	$(V) $(MAKE) linux -j $(LINUX_PAR_EXE) $(KERNEL_FLAGS) modules
# Install Kernel modules
	$(V) $(MKDIR) $(LINUX_PATH)/$(LINUX_MOD_INSTALLDIR)
	$(V) $(MAKE) linux $(KERNEL_FLAGS) INSTALL_MOD_PATH=$(LINUX_MOD_INSTALLPATH) modules_install
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

# Alias target to install linux
install: linux-install

uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall linux${MSG_END}"
	$(V) $(RM) linux-install

clean: header
	@$(ECHO) "${MSG_INFO}  Remove linux${MSG_END}"
	$(V) $(RM) linux-uncomp linux-build linux-install linux-patch linux-download linux-modules
# Remove Linux code
	$(V) $(RM) linux
# Remove linux modules
	$(V) $(RM) $(LINUX_MOD_INSTALLPATH) $(LINUX_KERNEL_INSTALLPATH)

debug:


