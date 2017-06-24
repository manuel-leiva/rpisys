
include board.defs
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

clean-all: clean
	$(V) $(MAKE) toolchain clean

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    clean:        Clean all the modules built"
	@$(ECHO) "    toolchain:    Build toolchain"
	@$(ECHO) "    bootloader:   Build bootloader"
	@$(ECHO) "    linux:        Build linux"
	@$(ECHO) "    filesystem:   Build filesystem"
	@$(ECHO) "    libraries:    Build libraries"
	@$(ECHO) "    applications: Build applications"
	@$(ECHO) "    image:        Build image"
	@$(ECHO) "    image-sd:     Install image generated into a SD card"
	@$(ECHO) "    image-file:   Create image file"

toolchain:
	$(V) $(MAKE) $@

bootloader: toolchain
	$(V) $(MAKE) $@

linux: bootloader
	$(V) $(MAKE) $@

filesystem:
	$(V) $(MAKE) $@

libraries: filesystem linux
	$(V) $(MAKE) $@

applications: libraries
	$(V) $(MAKE) $@

image: applications
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/bootloader install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/linux install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/libraries install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/filesystem install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/applications install
	$(V)$(MAKE) $@

image-clean:
	$(V)$(MAKE) image image-clean

image-sd:
	$(V) $(MAKE) image sd

image-file:
	$(V) $(MAKE) image file

board: board.defs

board-info:
	@echo "${MSG_INFO}  Name: ${BOARD_NAME}${MSG_END}"
	@echo "  Linux:      ${LINUX_NAMETAR}"
	@echo "  Filesystem: ${FILESYSTEM_NAMETAR}"
	@echo

# Private targets ##############################################################

board.defs:
ifdef BOARD
	$(V) system-build/scripts/init.sh \
    --pwd ${PWD} \
    --board ${BOARD}
else
	@echo "${MSG_ERROR}ERROR: Board variable not defined${MSG_END}"
	@echo "    board file needs to be defined"
	@echo "    Example: make board BOARD=board.defs"
	@echo
endif

debug-var:
	@echo "  PWD: ${PWD}"

