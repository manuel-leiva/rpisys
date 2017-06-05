
include Make.defs
include board.defs

include system-build/makefile/Makefile.common

.PHONY: all toolchain bootloader linux filesystem libraries applications image board

# Public targets ###############################################################

all: image

help:
	@$(ECHO) "  Targets:"
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

linux: toolchain
	$(V) $(MAKE) $@

filesystem:
	$(V) $(MAKE) $@

libraries: filesystem linux
	$(V) $(MAKE) $@

applications: libraries
	$(V) $(MAKE) $@

image: applications
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
	$(V) if [ -f board/${BOARD} ]; then \
        echo "${MSG_INFO}Install ${BOARD}${MSG_END}" ; \
        ln -s board/$(BOARD) board.defs ; \
    else \
        echo "${MSG_ERROR}ERROR: Board file $(BOARD) doesn't exist${MSG_END}" ; \
    fi
else
	@echo "${MSG_ERROR}ERROR: Board variable not defined${MSG_END}"
	@echo "    board file needs to be defined"
	@echo "    Example: make board BOARD=board.defs"
	@echo
endif

