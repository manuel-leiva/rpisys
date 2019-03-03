# Include machine definitions
include machine.defs
# Include local configuration
include system-build/makefile/Makefile.local
# Include common recipes and definitions
include system-build/makefile/Makefile.common

# Definitions ##################################################################

PWD:=$(shell pwd)

.PHONY: all clean toolchain bootloader linux filesystem libraries image machine

# Public targets ###############################################################

all: image

clean:
# Toolchain is not clean by default
	$(V) $(MAKE) bootloader clean
	$(V) $(MAKE) linux clean
	$(V) $(MAKE) filesystem clean
	$(V) $(MAKE) libraries clean
	$(V) $(MAKE) image clean

toolchain-clean:
	$(V) $(MAKE) toolchain clean

clean-all: clean tools-clean machine-clean

help:
	@$(ECHO) "  Targets:"
	@$(ECHO) "    tools:            Install system dependecies"
	@$(ECHO) "    machine:          Configure system for selected machine profile"
	@$(ECHO) "    clean:            Clean all the modules built"
	@$(ECHO) "    toolchain:        Build toolchain"
	@$(ECHO) "    bootloader:       Build bootloader"
	@$(ECHO) "    linux:            Build linux"
	@$(ECHO) "    filesystem:       Build filesystem"
	@$(ECHO) "    libraries:        Build libraries"
	@$(ECHO) "    image:            Build image"
	@$(ECHO) "    image-sd:         Install image generated into a SD card"
	@$(ECHO) "    image-file:       Create image file"

toolchain: machine
	$(V) $(MAKE) $@ install

bootloader: toolchain
	$(V) $(MAKE) $@ install

linux: toolchain
	$(V) $(MAKE) $@ install

filesystem: machine
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

machine: tools
	$(V) $(MAKE) machine

machine-clean:
	$(V) $(MAKE) $(PRJ_ROOT_PATH)/machine clean

machine-info:
	@$(ECHO) "${MSG_INFO}  Name: ${MACHINE_NAME}${MSG_END}"
	@$(ECHO) "  Linux:      ${MACHINE_LINUX_DL_URL}${MACHINE_LINUX_TAR_NAME}"
	@$(ECHO) "  Filesystem: ${MACHINE_FILESYSTEM_DL_URL}${MACHINE_FILESYSTEM_TAR_NAME}"
	@$(ECHO) "  Toolchain:  ${MACHINE_TOOLCHAIN_DL_URL}${MACHINE_TOOLCHAIN_TAR_NAME}"
	@$(ECHO)

# Private targets ##############################################################

$(SYSTEM_BUILD_PATH)/common_tools:
	$(V) $(ECHO) "${MSG_INFO}Check system dependency tools${MSG_END}"
	$(call COMMON_RECIPE_DEPENDENCY,$(SYSTEM_BUILD_PATH)/dependency.txt)
	$(V) touch $@

machine.defs:
	@$(ECHO) "${MSG_ERROR}ERROR:${MSG_END} System have not been configured"
	@$(ECHO) "    machine file needs to be defined"
	@$(ECHO) "    Example: ./configure --machine machine_name.defs"
	@$(ECHO)
	@exit 1

debug-var:
	@$(ECHO) "  PWD: ${PWD}"

