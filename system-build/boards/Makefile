# Include board definitions
include ../../board.defs
# Include local configuration
include ../../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef BOARD_PRJ_TOOLS_PATH
$(error ERROR: BOARD_PRJ_TOOLS_PATH not defined)
endif

# Public targets ###############################################################

.PHONY: all clean header

all: header install

header:
	$(V) $(ECHO) "${MSG_INFO}Board${MSG_END}"

install: header board-install

clean: header
	$(V) if [ -d ${LOCAL_BOARD_PATH}/toolchain.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove toolchain patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/toolchain/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/bootloader.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove bootloader patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/bootloader/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/linux.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove linux patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/linux/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/filesystem.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove filesystem patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/filesystem/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/libraries.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove libraries patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/libraries/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/applications.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove applications patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/applications/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/image.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove image patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/image/patches ; \
    fi
	$(RM) board-install
	$(RM) $(LOCAL_BOARD_PATH)/board_tools

$(LOCAL_BOARD_PATH)/board_tools:
	$(V) $(ECHO) "${MSG_INFO}  Check ${BOARD_NAME} dependency tools${MSG_END}"
	$(call COMMON_RECIPE_DEPENDENCY,$(BOARD_PRJ_TOOLS_PATH))
	$(V) touch $@


board-install: $(LOCAL_BOARD_PATH)/board_tools
# Create default directories
	$(V) $(ECHO) "${MSG_INFO}  Install external directories${MSG_END}"
	$(V) $(MKDIR) $(BOARD_PRJ_COMMON_PATH)
	$(V) $(MKDIR) $(BOARD_PRJ_DOWNLOAD_PATH)
# Install patches
	$(V) if [ -n "$BOARD_TOOLCHAIN_PATCHES_PATH}" ]; then \
        if [ -d "$BOARD_TOOLCHAIN_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install toolchain patches${MSG_END}" ; \
            ln -s ${BOARD_TOOLCHAIN_PATCHES_PATH} ${PRJ_ROOT_PATH}/toolchain/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_BOOTLOADER_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_BOOTLOADER_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install bootloader patches${MSG_END}" ; \
            ln -s ${BOARD_BOOTLOADER_PATCHES_PATH} ${PRJ_ROOT_PATH}/bootloader/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_LINUX_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_LINUX_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install linux patches${MSG_END}" ; \
            ln -s ${BOARD_TOOLCHAIN_PATCHES_PATH} ${PRJ_ROOT_PATH}/linux/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_FILESYSTEM_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_FILESYSTEM_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install filesystem patches${MSG_END}" ; \
            ln -s ${BOARD_FILESYSTEM_PATCHES_PATH} ${PRJ_ROOT_PATH}/filesystem/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_LIBRARIES_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_LIBRARIES_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install libraries patches${MSG_END}" ; \
            ln -s ${BOARD_LIBRARIES_PATCHES_PATH} ${PRJ_ROOT_PATH}/libraries/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_APPLICATIONS_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_APPLICATIONS_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install applications patches${MSG_END}" ; \
            ln -s ${BOARD_APPLICATIONS_PATCHES_PATH} ${PRJ_ROOT_PATH}/applications/patches ; \
        fi \
    fi
	$(V) if [ -n "${BOARD_IMAGE_PATCHES_PATH}" ]; then \
        if [ -d "${BOARD_IMAGE_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install image patches${MSG_END}" ; \
            ln -s ${BOARD_IMAGE_PATCHES_PATH} ${PRJ_ROOT_PATH}/image/patches ; \
        fi \
    fi
	$(V) touch $@

board-debug-var:
