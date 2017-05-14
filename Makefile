
include Make.defs

.PHONY: all toolchain bootloader linux filesystem libraries applications image

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

