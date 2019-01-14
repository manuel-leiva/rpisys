# Include board definitions
include board.defs
# Include local configuration
include system-build/makefile/Makefile.local
# Include common recipes and definitions
include system-build/makefile/Makefile.common

# Definitions ##################################################################

PWD:=$(shell pwd)

.PHONY: all clean toolchain bootloader linux filesystem libraries applications image board

# Public targets ###############################################################

all: image

clean:
# Toolchain is not clean by default
	$(V) $(MAKE) bootloader clean
	$(V) $(MAKE) linux clean
	$(V) $(MAKE) filesystem clean
	$(V) $(MAKE) libraries clean
	$(V) $(MAKE) applications clean
	$(V) $(MAKE) image clean

toolchain-clean:
	$(V) $(MAKE) toolchain clean

clean-all: clean tools-clean board-clean

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    tools:            Install system dependecies"
	@$(ECHO) "    board:            Configure system for selected board profile"
	@$(ECHO) "    clean:            Clean all the modules built"
	@$(ECHO) "    toolchain:        Build toolchain"
	@$(ECHO) "    bootloader:       Build bootloader"
	@$(ECHO) "    linux:            Build linux"
	@$(ECHO) "    filesystem:       Build filesystem"
	@$(ECHO) "    libraries:        Build libraries"
	@$(ECHO) "    applications:     Build applications"
	@$(ECHO) "    image:            Build image"
	@$(ECHO) "    image-sd:         Install image generated into a SD card"
	@$(ECHO) "    image-file:       Create image file"

toolchain: board
	$(V) $(MAKE) $@ install

bootloader: toolchain
	$(V) $(MAKE) $@ install

linux: toolchain
	$(V) $(MAKE) $@ install

filesystem: board
	$(V) $(MAKE) $@ install

libraries: filesystem linux
	$(V) $(MAKE) $@ install

image:  bootloader libraries


image-clean:
	$(V)$(MAKE) image clean

image-sd:
	$(V) $(MAKE) image sd

image-custom:
	$(V) $(MAKE) image custom

image-file:
	$(V) $(MAKE) image file

tools: $(SYSTEM_BUILD_PATH)/common_tools

tools-clean:
	$(V) $(RM) $(SYSTEM_BUILD_PATH)/common_tools

board: tools
	$(V) $(MAKE) system-build/boards

board-clean:
	$(V) $(MAKE) $(SYSTEM_BUILD_PATH)/boards clean

board-info:
	@$(ECHO) "${MSG_INFO}  Name: ${BOARD_NAME}${MSG_END}"
	@$(ECHO) "  Linux:      ${BOARD_LINUX_DL_URL}${BOARD_LINUX_TAR_NAME}"
	@$(ECHO) "  Filesystem: ${BOARD_FILESYSTEM_DL_URL}${BOARD_FILESYSTEM_TAR_NAME}"
	@$(ECHO) "  Toolchain:  ${BOARD_TOOLCHAIN_DL_URL}${BOARD_TOOLCHAIN_TAR_NAME}"
	@$(ECHO)

# Private targets ##############################################################

$(SYSTEM_BUILD_PATH)/common_tools:
	$(V) $(ECHO) "${MSG_INFO}Check system dependency tools${MSG_END}"
	$(call COMMON_RECIPE_DEPENDENCY,$(SYSTEM_BUILD_PATH)/dependency.txt)
	$(V) touch $@

board.defs:
	@$(ECHO) "${MSG_ERROR}ERROR:${MSG_END} System have not been configured"
	@$(ECHO) "    board file needs to be defined"
	@$(ECHO) "    Example: ./configure --board board_name.defs"
	@$(ECHO)
	@exit 1

debug-var:
	@$(ECHO) "  PWD: ${PWD}"

