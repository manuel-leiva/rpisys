# Include board definitions
include ../../board.defs
# Include local configuration
include ../../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../../system-build/makefile/Makefile.common

# Public targets ###############################################################

.PHONY: all clean header

all: header install

header:
	$(ECHO) "${MSG_INFO}Board${MSG_END}"

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
	$(RM) $(LOCAL_BOARD_PATH)/board_dependency

$(LOCAL_BOARD_PATH)/board_dependency:
	$(V) $(ECHO) "${MSG_INFO}  Check ${BOARD_NAME} dependencies${MSG_END}"
	$(call COMMON_RECIPE_DEPENDENCY,$(LOCAL_BOARD_PATH)/$(BOARD_DEPENDENCY_PKG_FILE))
	$(V) touch $@

board-install: $(LOCAL_BOARD_PATH)/board_dependency
# Create default directories
	$(MKDIR) $(BOARD_PRJ_COMMON_PATH)
	$(MKDIR) $(BOARD_PRJ_DOWNLOAD_PATH)
# Install patches
	$(V) if [ -d ${LOCAL_BOARD_PATH}/toolchain.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install toolchain patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/toolchain.patch ${PRJ_ROOT_PATH}/toolchain/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/bootloader.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install bootloader patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/bootloader.patch ${PRJ_ROOT_PATH}/bootloader/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/linux.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install linux patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/linux.patch ${PRJ_ROOT_PATH}/linux/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/filesystem.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install filesystem patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/filesystem.patch ${PRJ_ROOT_PATH}/filesystem/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/libraries.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install libraries patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/libraries.patch ${PRJ_ROOT_PATH}/libraries/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/applications.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install applications patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/applications.patch ${PRJ_ROOT_PATH}/applications/patches ; \
    fi
	$(V) if [ -d ${LOCAL_BOARD_PATH}/image.patch ]; then \
        $(ECHO) "${MSG_INFO}  Install image patches${MSG_END}" ; \
        ln -s ${LOCAL_BOARD_PATH}/image.patch ${PRJ_ROOT_PATH}/image/patches ; \
    fi
	touch $@

