# Include board definitions
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_TOOLCHAIN_DLURL
$(error ERROR: BOARD_TOOLCHAIN_DLURL not defined)
endif

ifndef BOARD_TOOLCHAIN_NAMETAR
$(error ERROR: BOARD_TOOLCHAIN_NAMETAR not defined)
endif

ifndef TOOLCHAIN_PATH
$(error ERROR: TOOLCHAIN_PATH not defined)
endif

ifndef TOOLCHAIN_PREFIX
$(error ERROR: TOOLCHAIN_PREFIX not defined)
endif

# Public targets ###############################################################

.PHONY: all clean

all: toolchain-header $(PRJ_COMMON_PATH)/toolchain-download

clean:
	$(V) ${RM} $(PRJ_COMMON_PATH)/${BOARD_TOOLCHAIN_PKG_NAME}
	$(V) ${RM} $(PRJ_COMMON_PATH)/toolchain-download

download: toolchain-header $(PRJ_COMMON_PATH)/toolchain-download

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    download:  Download toolchain package"

help-debug:
	@$(ECHO) "    toolchain-debug-var: Show variables used during build process"

#~ # Private targets ##############################################################

toolchain-header:
	@$(ECHO) "${MSG_INFO}Toolchain${MSG_END}"

$(PRJ_COMMON_PATH)/toolchain-download:
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name ${BOARD_TOOLCHAIN_PKG_NAME} \
    --pkg-target-name ${BOARD_TOOLCHAIN_NAMETAR} \
    --dl-path ${PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_TOOLCHAIN_DLURL} \
    --dest ${PRJ_COMMON_PATH}
	$(V) touch $@

toolchain-debug-var:
	@$(ECHO) PRJ_DOWNLOAD_PATH:       ${PRJ_DOWNLOAD_PATH}
	@$(ECHO) PRJ_COMMON_PATH:         ${PRJ_COMMON_PATH}
	@$(ECHO) BOARD_TOOLCHAIN_DLURL:   ${BOARD_TOOLCHAIN_DLURL}
	@$(ECHO) BOARD_TOOLCHAIN_NAMETAR: ${BOARD_TOOLCHAIN_NAMETAR}
	@$(ECHO)
