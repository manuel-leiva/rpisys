.PHONY: all clean header

# Include local definition
include ../Make.defs

# Local definitions
FILESYSTEM_PATH:=${RPISYS_PATH}/filesystem/filesystem

all: header filesystem-patch

header:
	@$(ECHO) "${MSG_INFO}Filesystem build${MSG_END} "


filesystem-download: $(DOWNLOADDIR)/$(FILESYSTEM_NAMETAR)
	@    $(ECHO) "${MSG_INFO}  Download filesystem${MSG_END}"
	$(V) $(RPISYS_PATH)/system-build/scripts/download-package.sh \
	filesystem ${FILESYSTEM_NAMETAR} ${DOWNLOADDIR} ${FILESYSTEM_DLURL} \
	${FILESYSTEM_PATH}
	$(V) touch $@

filesystem-patch: filesystem-download
	$(V) if [ -d ${RPISYS_PATH}/filesystem/patches ]; then \
        echo "${MSG_INFO}  Patch ${PKGNAME} ${MSG_END}" ; \
        quilt push -a ; \
    fi
	$(V) touch $@ ;

# Reverse patches
filesystem-revpatch:
# Verify if patches directory exists, if it exists, then verify if the
# flag filesystem-patch file exists, if it exists, then remove the
# patches
	$(V) if [ -d ${RPISYS_PATH}/filesystem/patches ]; then \
        if [ -f ${RPISYS_PATH}/filesystem/filesystem-patch ]; then \
            echo "${MSG_INFO}  Reverse patches filesystem ${MSG_END}" ; \
            quilt pop -a ; \
        fi \
    fi
	$(V) $(RM) filesystem-patch

clean: header
	@$(ECHO) "${MSG_INFO}  Remove filesystem${MSG_END}"
	$(V) $(RM) sys-filesystem-*

install:

