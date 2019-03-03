# Include board definitions
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifdef MACHINE_BOOTLOADER_TAR_NAME

ifndef MACHINE_BOOTLOADER_SHA1SUM
$(error ERROR: MACHINE_BOOTLOADER_SHA1SUM not defined)
endif

endif

ifndef MACHINE_BOOTLOADER_INSTALLATION_DIR
BOOTLOADER_INSTALLATION_PATH=${COMMON_IMAGE_BOOT_PATH}
else
BOOTLOADER_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(MACHINE_BOOTLOADER_INSTALLATION_DIR)
endif

# Private definitions ##########################################################
BOOTLOADER_PKG_PATH = $(PRJ_ROOT_PATH)/bootloader/${MACHINE_BOOTLOADER_PKG_NAME}
BOOTLOADER_PATH = $(PRJ_ROOT_PATH)/bootloader

# Create parameter list to download the package
ifdef MACHINE_BOOTLOADER_PKG_NAME
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS=--pkg-name ${MACHINE_BOOTLOADER_PKG_NAME}
endif
ifdef MACHINE_BOOTLOADER_PKG_NAME
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--pkg-target-name  ${MACHINE_BOOTLOADER_TAR_NAME}
endif
ifdef MACHINE_PRJ_DOWNLOAD_PATH
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--dl-path ${MACHINE_PRJ_DOWNLOAD_PATH}
endif
ifdef MACHINE_BOOTLOADER_DL_URL
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--dl-url ${MACHINE_BOOTLOADER_DL_URL}
endif
ifdef MACHINE_BOOTLOADER_SHA1SUM
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--sha1sum ${MACHINE_BOOTLOADER_SHA1SUM}
endif
ifdef MACHINE_BOOTLOADER_BRANCH
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--branch ${MACHINE_BOOTLOADER_BRANCH}
endif
ifdef MACHINE_BOOTLOADER_GIT_DEPTH
BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS+=--git-depth ${MACHINE_BOOTLOADER_GIT_DEPTH}
endif

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
	$(V) ${RM} ${MACHINE_BOOTLOADER_PKG_NAME}

bootloader-header:
	@$(ECHO) "${MSG_INFO}Bootloader${MSG_END} "

bootloader-download:
ifdef MACHINE_BOOTLOADER_TAR_NAME
	@$(ECHO) "${MSG_INFO}  Download bootloader${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    ${BOOTLOADER_DOWNLOAD_SCRIPT_PARAMS}
endif
	$(V) touch $@

bootloader-patch: bootloader-download
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Apply patch
	$(call COMMON_RECIPE_PATCH,$(BOOTLOADER_PATH),${MACHINE_BOOTLOADER_PKG_NAME})
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@

bootloader-make: bootloader-patch
	@$(ECHO) "${MSG_INFO}  Build bootloader${MSG_END}"
	$(V) touch $@

bootloader-install: bootloader-make
	@$(ECHO) "${MSG_INFO}  Install bootloader${MSG_END}"
	$(V) cd boot; find . | cpio -pdum ${BOOTLOADER_INSTALLATION_PATH}

bootloader-uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall bootloader${MSG_END}"
	$(V) $(RM) bootloader-install

# Reverse patches
bootloader-revpatch:
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Remove patch
	$(call COMMON_RECIPE_RM_PATCH,$(BOOTLOADER_PATH))
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) $(RM) bootloader-patch

# Debug targets ################################################################

bootloader-debug-help: bootloader-header
	@$(ECHO) "  Targets:"
	@$(ECHO) "    bootloader-debug-var:    Show variables used during build process"

bootloader-debug-var: bootloader-header
	@$(ECHO) MACHINE_BOOTLOADER_TAR_NAME:  ${MACHINE_BOOTLOADER_TAR_NAME}
	@$(ECHO) MACHINE_BOOTLOADER_DL_URL:   ${MACHINE_BOOTLOADER_DL_URL}
	@$(ECHO) BOOTLOADER_PKG_PATH: ${BOOTLOADER_PKG_PATH}
