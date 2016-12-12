


.PHONY: all clean header

# Include local definition
include ../Make.defs

# Local definitions

LINUX_DIR:=$(shell pwd)

# Create kernel compilation flags
KERNEL_FLAGS:=ARCH=arm CROSS_COMPILE=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX) KERNEL=$(LINUX_KERNEL_EXTRAFLAGS)

# Instalation paths
LINUX_KERNEL_INSTALLPATH:=$(LINUX_DIR)/$(LINUX_KERNEL_INSTALLDIR)
LINUX_MOD_INSTALLPATH   :=$(LINUX_DIR)/$(LINUX_MOD_INSTALLDIR)

all: header sys-linux-install

header:
	@$(ECHO) "${MSG_INFO}Linux build${MSG_END} "

$(DOWNLOADDIR)/$(TOOLCHAINNAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	#$(V) wget $(LINUXURL)/$(LINUXNAMETAR) -P $(DOWNLOADDIR)

sys-linux-uncomp: $(DOWNLOADDIR)/$(TOOLCHAINNAMETAR)
	@    $(ECHO) "${MSG_INFO}  Uncompress linux ${MSG_END}"
	$(V) $(MKDIR) $(COMMONDIR)
	$(V) tar -xf $(DOWNLOADDIR)/$(LINUXNAMETAR)
	$(V) touch $@

sys-linux-patch: sys-linux-uncomp
	@    $(ECHO) "${MSG_INFO}  Apply linux patches ${MSG_END}"
	$(V) touch $@

sys-linux-build: sys-linux-patch
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

sys-linux-modules: sys-linux-build
	@    $(ECHO) "${MSG_INFO}  Build linux modules ${MSG_END}"
	$(V) $(MAKE) linux -j $(LINUX_PAR_EXE) $(KERNEL_FLAGS) modules
# Install Kernel modules
	$(V) $(MKDIR) $(LINUX_DIR)/$(LINUX_MOD_INSTALLDIR)
	$(V) $(MAKE) linux $(KERNEL_FLAGS) INSTALL_MOD_PATH=$(LINUX_MOD_INSTALLPATH) modules_install
	$(V) touch $@

sys-linux-install: sys-linux-modules
	@$(ECHO) "${MSG_INFO}  Install linux${MSG_END}"
	touch $@

clean: header
	@$(ECHO) "${MSG_INFO}  Remove linux${MSG_END}"
	$(V) $(RM) sys-linux-uncomp sys-linux-build sys-linux-install sys-linux-patch
# Remove Linux code
	$(V) $(RM) linux
# Remove linux modules
	$(V) $(RM) $(LINUX_MOD_INSTALLPATH) $(LINUX_KERNEL_INSTALLPATH)

debug:


