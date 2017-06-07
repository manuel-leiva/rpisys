.PHONY: all clean header

# Include local definition
include ../board.defs

# Local definitions
FILESYSTEM_PATH:=${PRJ_ROOT_PATH}/filesystem/filesystem
FILESYSTEM_SU?=n

all: header filesystem-patch

header:
	@$(ECHO) "${MSG_INFO}Filesystem${MSG_END} "

filesystem-download:
	@    $(ECHO) "${MSG_INFO}  Download filesystem${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name filesystem \
    --pkg-target-name ${FILESYSTEM_NAMETAR} \
    --dl-path ${PRJ_DOWNLOAD_PATH} \
    --dl-url ${FILESYSTEM_DLURL} \
    --su ${FILESYSTEM_SU}
	$(V) touch $@

filesystem-patch: filesystem-download
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

clean: header
	@$(ECHO) "${MSG_INFO}  Remove filesystem${MSG_END}"
	$(V) $(RM) filesystem-*
ifeq ($(FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to clean filesystem${MSG_END}"
	$(V) sudo $(RM) filesystem
else
	$(V) $(RM) filesystem
endif

# Alias target for install
install: header filesystem-install

filesystem-install: filesystem-patch
	@$(ECHO) "${MSG_INFO}  Install filesystem${MSG_END}"
	$(V) $(MKDIR) ${PRJ_ROOT_PATH}/image/image/rootfs
ifeq ($(FILESYSTEM_SU),y)
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to install filesystem${MSG_END}"
	$(V) cd filesystem; sudo find . | sudo cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs/
else
	$(V) cd filesystem; find . | cpio -pdum ${PRJ_ROOT_PATH}/image/image/rootfs/
endif
	$(V) touch $@

uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall filesystem${MSG_END}"
	$(V) $(RM) filesystem-install
