# Include board definition
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##

## Local definitions ##
# Install kernel modules in the filesystem by default
ifndef BOARD_LIBRARY_INSTALLATION_DIR
LIBRARY_INSTALLATION_PATH=${COMMON_IMAGE_ROOTFS_PATH}
else
LIBRARY_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(BOARD_LIBRARY_INSTALLATION_DIR)
endif

# Public targets ###############################################################
.PHONY: $(BOARD_LIBRARY_NAME_LIST)


define BUILD_RECIPE
$(1): $(2)
	$(V)$(MAKE) $(1)
	$(V)$(MAKE) $(1) install

endef

define CLEAN_RECIPE
clean-$(1):
	$(V)$(MAKE) $(1) clean

endef

LIB_CLEAN_TARGET_LIST:=$(BOARD_LIBRARY_NAME_LIST:%=clean-%)


all: libraries-header $(BOARD_LIBRARY_NAME_LIST)

clean: libraries-header $(LIB_CLEAN_TARGET_LIST)
	@$(ECHO) "${MSG_INFO}  Clean Libraries ${MSG_END}"
	@$(RM) host-libs board-libs libraries-install

# Alias target to install linux
install: libraries-install

uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall libraries${MSG_END}"
	$(V) $(RM) libraries-install

# Build targets
$(info $(foreach i,$(BOARD_LIBRARY_NAME_LIST),$(eval $(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi )))))

# Clean targets
$(info $(foreach i,$(BOARD_LIBRARY_NAME_LIST),$(eval $(call CLEAN_RECIPE,$(i)))))

# Private targets ###############################################################

libraries-header:
	@$(ECHO) "${MSG_INFO}Libraries${MSG_END}"

libraries-install:
	@$(ECHO) "${MSG_INFO}  Libraries install${MSG_END}"
	$(V) cd board-libs; find . | cpio -pdum ${LIBRARY_INSTALLATION_PATH}
	$(V) touch $@


libraries-debug-targets:
# The lines must be coherent with the lines used in order to show the real recipes
	@echo $(info $(foreach i,$(BOARD_LIBRARY_NAME_LIST),$(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi ))))
	@echo $(info $(foreach i,$(LIB_CLEAN_TARGET_LIST),$(call CLEAN_RECIPE,$(i))))

libraries-debug-var:
	@echo "BOARD_LIBRARY_NAME_LIST: $(BOARD_LIBRARY_NAME_LIST)"
	@echo "LIB_CLEAN_TARGET_LIST: $(LIB_CLEAN_TARGET_LIST)"
