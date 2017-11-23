# Include board definitions
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_FILESYSTEM_PKG_NAME_TAR
$(error ERROR: BOARD_FILESYSTEM_PKG_NAME_TAR not defined)
endif
ifndef BOARD_FILESYSTEM_DL_URL
$(error ERROR: BOARD_FILESYSTEM_DL_URL not defined)
endif
ifndef BOARD_FILESYSTEM_PKG_NAME
$(error ERROR: BOARD_FILESYSTEM_PKG_NAME not defined)
endif
ifndef BOARD_FILESYSTEM_SHA1SUM
$(error ERROR: BOARD_FILESYSTEM_SHA1SUM not defined)
endif
BOARD_FILESYSTEM_DEST_DIR?=./

## Local definitions ##
FILESYSTEM_PATH:=${PRJ_ROOT_PATH}/filesystem
BOARD_FILESYSTEM_SU?=n

## Exported definitions
export FILESYSTEM_PKG_PATH:=${PRJ_ROOT_PATH}/filesystem/${BOARD_FILESYSTEM_PKG_NAME}

# Public targets ###############################################################

.PHONY: all clean header

all: header filesystem-patch

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
	$(call COMMON_RECIPE_RM_PATCH,$(FILESYSTEM_PATH))
ifeq ($(BOARD_FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to clean filesystem${MSG_END}"
	$(V) sudo $(RM) filesystem
else
	$(V) $(RM) filesystem
endif

filesystem-download:
	@    $(ECHO) "${MSG_INFO}  Download filesystem${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name filesystem \
    --pkg-target-name ${BOARD_FILESYSTEM_PKG_NAME_TAR} \
    --sha1sum ${BOARD_FILESYSTEM_SHA1SUM} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_FILESYSTEM_DL_URL} \
    --su ${BOARD_FILESYSTEM_SU} \
    --dest ${FILESYSTEM_PATH}/${BOARD_FILESYSTEM_DEST_DIR}
	$(V) touch $@

filesystem-patch: filesystem-download
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Apply patch
	$(call COMMON_RECIPE_PATCH,$(FILESYSTEM_PATH),${BOARD_FILESYSTEM_PKG_NAME})
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@

# Reverse patches
filesystem-revpatch:
# Verify if patches directory exists, if it exists, then verify if the
# flag filesystem-patch file exists, if it exists, then remove the
# patches
	$(V) if [ -d ${PRJ_ROOT_PATH}/filesystem/patches ]; then \
        if [ -f ${PRJ_ROOT_PATH}/filesystem/filesystem-patch ]; then \
            echo "${MSG_INFO}  Reverse patches filesystem ${MSG_END}" ; \
            quilt pop -a ; \
        fi \
    fi
	$(V) $(RM) filesystem-patch

filesystem-install: filesystem-patch
	@$(ECHO) "${MSG_INFO}  Install filesystem${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/rootfs
ifeq ($(BOARD_FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to install filesystem${MSG_END}"
	$(V) cd filesystem; sudo find . | sudo cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs/
else
	$(V) cd filesystem; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs/
endif
	$(V) touch $@

linux-export-var:
	@$(ECHO) FILESYSTEM_PKG_PATH: ${FILESYSTEM_PKG_PATH}
