
.PHONY: all clean


# Include local definition
include ../Make.defs


all: sys-linux-build

$(DOWNLOADDIR)/$(TOOLCHAINNAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	#$(V) wget $(LINUXURL)/$(LINUXNAMETAR) -P $(DOWNLOADDIR)

sys-linux-uncomp: $(DOWNLOADDIR)/$(TOOLCHAINNAMETAR)
	@$(ECHO) "${MSG_INFO}  Uncompress linux ${MSG_END}"
	$(V) mkdir -p $(COMMONDIR)
	$(V) tar -xf $(DOWNLOADDIR)/$(LINUXNAMETAR)
	$(V) touch sys-linux-uncomp

sys-linux-patch: sys-linux-uncomp
	@$(ECHO) "${MSG_INFO}  Apply linux patches ${MSG_END}"
	touch sys-linux-patch

sys-linux-build: sys-linux-patch
	@$(ECHO) "${MSG_INFO}  Build linux ${MSG_END}"
	export kernel7
	export export PATH=~/rpisys/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
	make -C linux KERNEL=kernel7
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
	touch sys-linux-build

sys-linux-install: sys-linux-build
	@$(ECHO) "${MSG_INFO}  Install linux${MSG_END}"
	touch sys-linux-install


clean:
	$(V) rm sys-linux-uncomp sys-linux-build

