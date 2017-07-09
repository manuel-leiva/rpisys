# Include board definitions
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_FILESYSTEM_NAME_TAR
$(error ERROR: BOARD_FILESYSTEM_NAME_TAR not defined)
endif
ifndef BOARD_FILESYSTEM_DL_URL
$(error ERROR: BOARD_FILESYSTEM_DL_URL not defined)
endif
ifndef BOARD_FILESYSTEM_PKG_DIR
$(error ERROR: BOARD_FILESYSTEM_DL_URL not defined)
endif

## Local definitions ##
FILESYSTEM_PATH:=${PRJ_ROOT_PATH}/filesystem
BOARD_FILESYSTEM_SU?=n

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
    --pkg-target-name ${BOARD_FILESYSTEM_NAME_TAR} \
    --dl-path ${PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_FILESYSTEM_DL_URL} \
    --su ${BOARD_FILESYSTEM_SU}
	$(V) touch $@

filesystem-script-download-post: filesystem-download
ifdef BOARD_FILESYSTEM_POST_DOWNLOAD_SCRIPT
	@    $(ECHO) "${MSG_INFO}  Run download post script${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/boards/scripts/${BOARD_FILESYSTEM_POST_DOWNLOAD_SCRIPT} \
	--pwd ${FILESYSTEM_PATH} \
	--fs-dir ${BOARD_FILESYSTEM_PKG_DIR}
	$(V) touch $@
endif

filesystem-patch: filesystem-script-download-post
	$(V) if [ -d ${PRJ_ROOT_PATH}/filesystem/patches ]; then \
        echo "${MSG_INFO}  Patch ${PKGNAME} ${MSG_END}" ; \
        quilt push -a ; \
    fi
	$(V) touch $@ ;

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


