# Include board definitions
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef MACHINE_FILESYSTEM_TAR_NAME
$(error ERROR: MACHINE_FILESYSTEM_TAR_NAME not defined)
endif
ifndef MACHINE_FILESYSTEM_DL_URL
$(error ERROR: MACHINE_FILESYSTEM_DL_URL not defined)
endif
ifndef MACHINE_FILESYSTEM_PKG_NAME
$(error ERROR: MACHINE_FILESYSTEM_PKG_NAME not defined)
endif
ifndef MACHINE_FILESYSTEM_SHA1SUM
$(error ERROR: MACHINE_FILESYSTEM_SHA1SUM not defined)
endif
MACHINE_FILESYSTEM_DEST_DIR?=./

## Local definitions ##
FILESYSTEM_PATH:=${PRJ_ROOT_PATH}/filesystem
MACHINE_FILESYSTEM_SU?=n

ifndef MACHINE_FILESYSTEM_INSTALLATION_DIR
FILESYSTEM_INSTALLATION_PATH=${COMMON_IMAGE_ROOTFS_PATH}
else
FILESYSTEM_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(MACHINE_FILESYSTEM_INSTALLATION_DIR)
endif

## Exported definitions
export FILESYSTEM_PKG_PATH:=${PRJ_ROOT_PATH}/filesystem/${MACHINE_FILESYSTEM_PKG_NAME}

# Create parameter list to download the package
ifdef MACHINE_FILESYSTEM_PKG_NAME
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS=--pkg-name ${MACHINE_FILESYSTEM_PKG_NAME}
endif
ifdef MACHINE_FILESYSTEM_PKG_NAME
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--pkg-target-name  ${MACHINE_FILESYSTEM_TAR_NAME}
endif
ifdef MACHINE_PRJ_DOWNLOAD_PATH
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--dl-path ${MACHINE_PRJ_DOWNLOAD_PATH}
endif
ifdef MACHINE_FILESYSTEM_DL_URL
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--dl-url ${MACHINE_FILESYSTEM_DL_URL}
endif
ifdef MACHINE_FILESYSTEM_SHA1SUM
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--sha1sum ${MACHINE_FILESYSTEM_SHA1SUM}
endif
ifdef MACHINE_FILESYSTEM_BRANCH
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--branch ${MACHINE_FILESYSTEM_BRANCH}
endif
ifdef MACHINE_FILESYSTEM_GIT_DEPTH
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--git-depth ${MACHINE_FILESYSTEM_GIT_DEPTH}
endif
ifdef MACHINE_FILESYSTEM_SU
FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS+=--su ${MACHINE_FILESYSTEM_SU}
endif

# Public targets ###############################################################

.PHONY: all clean header

all: header filesystem-packages

header:
	@$(ECHO) "${MSG_INFO}Filesystem${MSG_END} "

clean: header filesystem-clean

# Alias target for install
install: header filesystem-install

uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall filesystem${MSG_END}"
	$(V) $(RM) filesystem-install

# Private targets ###############################################################

filesystem-clean: filesystem-revpatch
	@$(ECHO) "${MSG_INFO}  Remove filesystem${MSG_END}"
	$(V) $(RM) filesystem-*
ifeq ($(MACHINE_FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need super user permissions to clean the filesystem${MSG_END}"
	$(V) sudo $(RM) filesystem
else
	$(V) $(RM) filesystem
endif

filesystem-download:
	@    $(ECHO) "${MSG_INFO}  Download filesystem${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    ${FILESYSTEM_DOWNLOAD_SCRIPT_PARAMS}
# Install machine filesystem files from symbolic link
# Check if the symbolic link exist
	$(V) if [ -h "${COMMON_CUSTOM_FILESYSTEM_SL_NAME}" ]; then \
        $(ECHO) "${MSG_INFO}    Install custom files: ${MSG_END} ${MACHINE_FILESYSTEM_INSTALL_DIR}" ; \
        sudo $(CP) -a $(COMMON_CUSTOM_FILESYSTEM_SL_NAME)/* $(MACHINE_FILESYSTEM_PKG_NAME) ; \
    fi
	$(V) touch $@

filesystem-patch: filesystem-download
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Apply patch
	$(call COMMON_RECIPE_PATCH,$(FILESYSTEM_PATH),${MACHINE_FILESYSTEM_PKG_NAME})
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@

# Reverse patches
filesystem-revpatch:
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Remove patch
	$(call COMMON_RECIPE_RM_PATCH,$(FILESYSTEM_PATH))
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) $(RM) filesystem-patch

filesystem-packages: filesystem-patch
ifdef MACHINE_FILESYSTEM_PACKAGES_LIST
	@$(ECHO) "${MSG_INFO}  Install packages${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/filesystem-packages-installer.sh \
       --cpu-family ${MACHINE_CPU} \
       --filesystem ${FILESYSTEM_PKG_PATH} \
       --packages   ${MACHINE_FILESYSTEM_PACKAGES_LIST}
endif


filesystem-install: filesystem-packages
	@$(ECHO) "${MSG_INFO}  Install filesystem${MSG_END}"
	$(V) $(MKDIR) ${FILESYSTEM_INSTALLATION_PATH}
ifeq ($(MACHINE_FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need super user permissions to install the filesystem${MSG_END}"
	$(V) cd filesystem; sudo find . | sudo cpio -pdum ${FILESYSTEM_INSTALLATION_PATH}
else
	$(V) cd filesystem; find . | cpio -pdum ${FILESYSTEM_INSTALLATION_PATH}
endif

linux-export-var:
	@$(ECHO) FILESYSTEM_PKG_PATH: ${FILESYSTEM_PKG_PATH}
