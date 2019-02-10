# Include board definitions
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef MACHINE_TOOLCHAIN_DL_URL
$(error ERROR: MACHINE_TOOLCHAIN_DL_URL not defined)
endif

ifndef MACHINE_TOOLCHAIN_TAR_NAME
$(error ERROR: MACHINE_TOOLCHAIN_TAR_NAME not defined)
endif

ifndef MACHINE_TOOLCHAIN_PKG_NAME
$(error ERROR: MACHINE_TOOLCHAIN_PKG_NAME not defined)
endif

ifndef MACHINE_TOOLCHAIN_SHA1SUM
$(error ERROR: MACHINE_TOOLCHAIN_SHA1SUM not defined)
endif

ifndef MACHINE_TOOLCHAIN_PATH
$(error ERROR: MACHINE_TOOLCHAIN_PATH not defined)
endif

ifndef MACHINE_TOOLCHAIN_PREFIX
$(error ERROR: MACHINE_TOOLCHAIN_PREFIX not defined)
endif

## Exported variables
export TOOLCHAIN_PKG_PATH:=$(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)

# Create parameter list to download the package
ifdef MACHINE_TOOLCHAIN_PKG_NAME
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS=--pkg-name ${MACHINE_TOOLCHAIN_PKG_NAME}
endif
ifdef MACHINE_TOOLCHAIN_PKG_NAME
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--pkg-target-name  ${MACHINE_TOOLCHAIN_TAR_NAME}
endif
ifdef MACHINE_PRJ_DOWNLOAD_PATH
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--dl-path ${MACHINE_PRJ_DOWNLOAD_PATH}
endif
ifdef MACHINE_TOOLCHAIN_DEST
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--dest ${MACHINE_TOOLCHAIN_DEST}
endif
ifdef MACHINE_TOOLCHAIN_DL_URL
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--dl-url ${MACHINE_TOOLCHAIN_DL_URL}
endif
ifdef MACHINE_TOOLCHAIN_SHA1SUM
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--sha1sum ${MACHINE_TOOLCHAIN_SHA1SUM}
endif
ifdef MACHINE_TOOLCHAIN_BRANCH
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--branch ${MACHINE_TOOLCHAIN_BRANCH}
endif
ifdef MACHINE_TOOLCHAIN_GIT_DEPTH
TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS+=--git-depth ${MACHINE_TOOLCHAIN_GIT_DEPTH}
endif

# Public targets ###############################################################

.PHONY: all clean

all: toolchain-header $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-build

install: all

clean: toolchain-header toolchain-clean

download: toolchain-header $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-download

build: toolchain-header $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-build

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    download:  Download toolchain package"
	@$(ECHO) "    build:     Build toolchain"

help-debug:
	@$(ECHO) "    toolchain-debug-var: Show variables used during build process"

# Private targets ##############################################################

toolchain-header:
	@$(ECHO) "${MSG_INFO}Toolchain${MSG_END}"

toolchain-clean:
	@$(ECHO) "${MSG_INFO}  Remove Toolchain${MSG_END}"
	$(V) ${RM} $(MACHINE_PRJ_COMMON_PATH)/${MACHINE_TOOLCHAIN_PKG_NAME}
	$(V) ${RM} $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-download
	$(V) ${RM} $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-build

$(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-download:
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    ${TOOLCHAIN_DOWNLOAD_SCRIPT_PARAMS}
# Call toolchain-download-post
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),toolchain-download-post)
	$(V) touch $@

$(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-build: $(MACHINE_PRJ_COMMON_PATH)/$(MACHINE_TOOLCHAIN_PKG_NAME)/toolchain-download
	@$(ECHO) "${MSG_INFO}  Build Toolchain${MSG_END}"
# Call toolchain build hook
	$(call COMMON_RECIPE_HOOK,$(MACHINE_PRJ_MAKEFILE_HOOKS_PATH),toolchain-build)
	$(V) touch $@

toolchain-debug-var:
	@$(ECHO) MACHINE_PRJ_DOWNLOAD_PATH: ${MACHINE_PRJ_DOWNLOAD_PATH}
	@$(ECHO) MACHINE_PRJ_COMMON_PATH:   ${MACHINE_PRJ_COMMON_PATH}
	@$(ECHO) MACHINE_TOOLCHAIN_DL_URL:   ${MACHINE_TOOLCHAIN_DL_URL}
	@$(ECHO) MACHINE_TOOLCHAIN_TAR_NAME: ${MACHINE_TOOLCHAIN_TAR_NAME}
	@$(ECHO)
