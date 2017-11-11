# Include board definitions
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_TOOLCHAIN_DL_URL
$(error ERROR: BOARD_TOOLCHAIN_DL_URL not defined)
endif

ifndef BOARD_TOOLCHAIN_NAMETAR
$(error ERROR: BOARD_TOOLCHAIN_NAMETAR not defined)
endif

ifndef BOARD_TOOLCHAIN_SHA1SUM
$(error ERROR: BOARD_TOOLCHAIN_SHA1SUM not defined)
endif

ifndef BOARD_TOOLCHAIN_PATH
$(error ERROR: BOARD_TOOLCHAIN_PATH not defined)
endif

ifndef BOARD_TOOLCHAIN_PREFIX
$(error ERROR: BOARD_TOOLCHAIN_PREFIX not defined)
endif

# Public targets ###############################################################

.PHONY: all clean

all: toolchain-header $(BOARD_PRJ_COMMON_PATH)/toolchain-download

clean: toolchain-header toolchain-clean

download: toolchain-header $(BOARD_PRJ_COMMON_PATH)/toolchain-download

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    download:  Download toolchain package"

help-debug:
	@$(ECHO) "    toolchain-debug-var: Show variables used during build process"

#~ # Private targets ##############################################################

toolchain-header:
	@$(ECHO) "${MSG_INFO}Toolchain${MSG_END}"

toolchain-clean:
	@$(ECHO) "${MSG_INFO}  Remove Toolchain${MSG_END}"
	$(V) ${RM} $(BOARD_PRJ_COMMON_PATH)/${BOARD_TOOLCHAIN_PKG_NAME}
	$(V) ${RM} $(BOARD_PRJ_COMMON_PATH)/toolchain-download

$(BOARD_PRJ_COMMON_PATH)/toolchain-download:
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name ${BOARD_TOOLCHAIN_PKG_NAME} \
    --pkg-target-name ${BOARD_TOOLCHAIN_NAMETAR} \
    --sha1sum ${BOARD_TOOLCHAIN_SHA1SUM} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_TOOLCHAIN_DL_URL} \
    --dest ${BOARD_PRJ_COMMON_PATH}
	$(V) touch $@

toolchain-debug-var:
	@$(ECHO) BOARD_PRJ_DOWNLOAD_PATH: ${BOARD_PRJ_DOWNLOAD_PATH}
	@$(ECHO) BOARD_PRJ_COMMON_PATH:   ${BOARD_PRJ_COMMON_PATH}
	@$(ECHO) BOARD_TOOLCHAIN_DL_URL:   ${BOARD_TOOLCHAIN_DL_URL}
	@$(ECHO) BOARD_TOOLCHAIN_NAMETAR: ${BOARD_TOOLCHAIN_NAMETAR}
	@$(ECHO)
