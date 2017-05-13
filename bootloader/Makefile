

include ../Make.defs
include $(INCLUDE_MAKE_PATH)/Makefile.common

# Private definitions ##########################################################
BOOTLOADER_PKG_PATH = $(PRJ_ROOT_PATH)/bootloader/bootloader

# Public targets ###############################################################
all: bootloader-header bootloader-make

# Alias target to download the package
download: bootloader-header bootloader-download

# Alias target to install the package
install: bootloader-header bootloader-install

uninstall: bootloader-header bootloader-uninstall

help: bootloader-header
	@$(ECHO) "  Targets:"
	@$(ECHO) "    all:       Build bootloader package"
	@$(ECHO) "    install:   Install bootloader package"
	@$(ECHO) "    uninstall: Uninstall bootloader package"
	@$(ECHO) "    download:  Download bootloader package"

# Private targets ##############################################################

bootloader-header:
	@$(ECHO) "${MSG_INFO}Bootloader${MSG_END} "

bootloader-download:
	@$(ECHO) "${MSG_INFO}  Download bootloader${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name bootloader \
    --pkg-target-name $(BOOTLOADER_NAMETAR) \
    --dl-path ${PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOOTLOADER_DL_URL}
	$(V) touch $@

# bootloader-patch:
# Parameters: target_prefix, dependecies, package-path, message
$(eval $(call COMMON_PATCH_RECIPE,bootloader,bootloader-download,${BOOTLOADER_PKG_PATH},bootloader))

bootloader-make: bootloader-patch
	@$(ECHO) "${MSG_INFO}  Build bootloader${MSG_END}"
	$(V) touch $@

bootloader-install: bootloader-make
	@$(ECHO) "${MSG_INFO}  Install bootloader${MSG_END}"
	$(V) cd boot; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/boot
	$(V) touch $@

bootloader-uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall bootloader${MSG_END}"
	$(V) $(RM) bootloader-install

# bootloader-revpatch:
# Parameters: target_prefix, dependecies, package-path, message
$(eval $(call COMMON_REVPATCH_RECIPE,bootloader,,${BOOTLOADER_PKG_PATH},bootloader))

# Debug targets ################################################################

bootloader-debug-help: bootloader-header
	@$(ECHO) "  Targets:"
	@$(ECHO) "    bootloader-debug-var:    Show variables used during build process"

bootloader-debug-var: bootloader-header
	@$(ECHO) BOOTLOADER_NAMETAR:  ${BOOTLOADER_NAMETAR}
	@$(ECHO) BOOTLOADER_DL_URL:   ${TOOLCHAIN_DL_URL}
	@$(ECHO) BOOTLOADER_PKG_PATH: ${BOOTLOADER_PKG_PATH}
