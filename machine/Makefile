# Include board definitions
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##
ifndef MACHINE_PRJ_TOOLS_PATH
$(error ERROR: MACHINE_PRJ_TOOLS_PATH not defined)
endif

ifndef PRJ_ROOT_PATH
$(error ERROR: PRJ_ROOT_PATH not defined)
endif

# Public targets ###############################################################

.PHONY: all clean header

all: header install

header:
	$(V) $(ECHO) "${MSG_INFO}Board${MSG_END}"

install: header board-install

clean: header
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/toolchain.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove toolchain patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/toolchain/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/bootloader.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove bootloader patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/bootloader/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/linux.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove linux patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/linux/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/filesystem.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove filesystem patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/filesystem/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/libraries.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove libraries patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/libraries/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/applications.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove applications patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/applications/patches ; \
    fi
	$(V) if [ -d ${LOCAL_MACHINE_PATH}/image.patch ]; then \
        $(ECHO) "${MSG_INFO}  Remove image patches${MSG_END}" ; \
        $(RM) ${PRJ_ROOT_PATH}/image/patches ; \
    fi
# Install board libraries
	$(V) if [ -n "${MACHINE_LIBRARY_INSTALL_DIR}" ]; then \
	$(ECHO) "${MSG_INFO}  Remove Library${MSG_END}" ; \
        for LIBRARY_DIR in $(MACHINE_LIBRARY_INSTALL_DIR) ; do \
            if [ -d "$${LIBRARY_DIR}" ]; then \
                BASENAME="$$(basename $$LIBRARY_DIR)"  ; \
                $(ECHO) "${MSG_INFO}    Library $${BASENAME}${MSG_END}" ; \
                $(RM) ${PRJ_ROOT_PATH}/libraries/$$BASENAME ; \
            else \
                $(ECHO) "    ${MSG_WARN}WARN:${MSG_END} The directory \"${PRJ_ROOT_PATH}/libraries/$$BASENAME\" doesn't exist"; \
            fi \
        done \
    fi
	$(V) $(RM) board-install
	$(V) $(RM) $(LOCAL_MACHINE_PATH)/board_tools

$(LOCAL_MACHINE_PATH)/board_tools:
	$(V) $(ECHO) "${MSG_INFO}  Check ${MACHINE_NAME} dependency tools${MSG_END}"
	$(call COMMON_RECIPE_DEPENDENCY,$(MACHINE_PRJ_TOOLS_PATH))
	$(V) touch $@


board-install: $(LOCAL_MACHINE_PATH)/board_tools
# Create default directories
	$(V) $(ECHO) "${MSG_INFO}  Install external directories${MSG_END}"
	$(V) $(MKDIR) $(MACHINE_PRJ_COMMON_PATH)
	$(V) $(MKDIR) $(MACHINE_PRJ_DOWNLOAD_PATH)
# Install patches
	$(V) if [ -n "$MACHINE_TOOLCHAIN_PATCHES_PATH}" ]; then \
        if [ -d "$MACHINE_TOOLCHAIN_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install toolchain patches${MSG_END}" ; \
            ln -s ${MACHINE_TOOLCHAIN_PATCHES_PATH} ${PRJ_ROOT_PATH}/toolchain/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_BOOTLOADER_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_BOOTLOADER_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install bootloader patches${MSG_END}" ; \
            ln -s ${MACHINE_BOOTLOADER_PATCHES_PATH} ${PRJ_ROOT_PATH}/bootloader/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_LINUX_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_LINUX_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install linux patches${MSG_END}" ; \
            ln -s ${MACHINE_LINUX_PATCHES_PATH} ${PRJ_ROOT_PATH}/linux/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_FILESYSTEM_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_FILESYSTEM_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install filesystem patches${MSG_END}" ; \
            ln -s ${MACHINE_FILESYSTEM_PATCHES_PATH} ${PRJ_ROOT_PATH}/filesystem/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_LIBRARIES_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_LIBRARIES_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install libraries patches${MSG_END}" ; \
            ln -s ${MACHINE_LIBRARIES_PATCHES_PATH} ${PRJ_ROOT_PATH}/libraries/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_APPLICATIONS_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_APPLICATIONS_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install applications patches${MSG_END}" ; \
            ln -s ${MACHINE_APPLICATIONS_PATCHES_PATH} ${PRJ_ROOT_PATH}/applications/patches ; \
        fi \
    fi
	$(V) if [ -n "${MACHINE_IMAGE_PATCHES_PATH}" ]; then \
        if [ -d "${MACHINE_IMAGE_PATCHES_PATH}" ]; then \
            $(ECHO) "${MSG_INFO}  Install image patches${MSG_END}" ; \
            ln -s ${MACHINE_IMAGE_PATCHES_PATH} ${PRJ_ROOT_PATH}/image/patches ; \
        fi \
    fi
# Install board libraries
	$(V) if [ -n "${MACHINE_LIBRARY_INSTALL_DIR}" ]; then \
	$(ECHO) "${MSG_INFO}  Install Library${MSG_END}" ; \
        for LIBRARY_DIR in $(MACHINE_LIBRARY_INSTALL_DIR) ; do \
            if [ -d "$${LIBRARY_DIR}" ]; then \
                $(ECHO) "${MSG_INFO}    Library $${LIBRARY_DIR}${MSG_END}" ; \
                BASENAME="$$(basename $$LIBRARY_DIR)"  ; \
                cp -r $${LIBRARY_DIR} ${PRJ_ROOT_PATH}/libraries/$$BASENAME ; \
            else \
                $(ECHO) "    ${MSG_WARN}WARN:${MSG_END} The directory $${LIBRARY_DIR} doesn't exist"; \
            fi \
        done \
    fi
	$(V) touch $@

board-debug-var:
