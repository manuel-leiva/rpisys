# Include board definitions
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifdef BOARD_BOOTLOADER_TAR_NAME

ifndef BOARD_BOOTLOADER_SHA1SUM
$(error ERROR: BOARD_BOOTLOADER_SHA1SUM not defined)
endif

endif

# Private definitions ##########################################################
BOOTLOADER_PKG_PATH = $(PRJ_ROOT_PATH)/bootloader/${BOARD_BOOTLOADER_PKG_NAME}
BOOTLOADER_PATH = $(PRJ_ROOT_PATH)/bootloader

# Public targets ###############################################################
all: bootloader-header bootloader-make

clean: bootloader-header bootloader-clean

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

bootloader-clean: bootloader-revpatch
	@    $(ECHO) "${MSG_INFO}  Remove bootloader${MSG_END}"
	$(call COMMON_RECIPE_RM_PATCH,$(BOOTLOADER_PATH))
	$(V) ${RM} bootloader-install bootloader-patch bootloader-download bootloader-make
	$(V) ${RM} ${BOARD_BOOTLOADER_PKG_NAME}

bootloader-header:
	@$(ECHO) "${MSG_INFO}Bootloader${MSG_END} "

bootloader-download:
ifdef BOARD_BOOTLOADER_TAR_NAME
	@$(ECHO) "${MSG_INFO}  Download bootloader${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name bootloader \
    --pkg-target-name $(BOARD_BOOTLOADER_TAR_NAME) \
    --sha1sum ${BOARD_BOOTLOADER_SHA1SUM} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_BOOTLOADER_DL_URL}
endif
	$(V) touch $@

# bootloader-patch:
# Parameters: target_prefix, dependecies, package-path, message
$(eval $(call COMMON_TARGET_PATCH,bootloader,bootloader-download,${BOOTLOADER_PATH},bootloader))

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
$(eval $(call COMMON_TARGET_REVPATCH,bootloader,,${BOOTLOADER_PATH},bootloader))

# Debug targets ################################################################

bootloader-debug-help: bootloader-header
	@$(ECHO) "  Targets:"
	@$(ECHO) "    bootloader-debug-var:    Show variables used during build process"

bootloader-debug-var: bootloader-header
	@$(ECHO) BOARD_BOOTLOADER_TAR_NAME:  ${BOARD_BOOTLOADER_TAR_NAME}
	@$(ECHO) BOARD_BOOTLOADER_DL_URL:   ${BOARD_BOOTLOADER_DL_URL}
	@$(ECHO) BOOTLOADER_PKG_PATH: ${BOOTLOADER_PKG_PATH}
