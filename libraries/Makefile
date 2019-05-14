# Include board definition
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Verify external variables ##

## Local definitions ##
# Install kernel modules in the filesystem by default
ifndef MACHINE_LIBRARY_INSTALLATION_DIR
LIBRARY_INSTALLATION_PATH=${COMMON_IMAGE_ROOTFS_PATH}
else
LIBRARY_INSTALLATION_PATH=${PRJ_ROOT_PATH}/image/$(MACHINE_LIBRARY_INSTALLATION_DIR)
endif

## Private definitions
# Directory to import files from filesystem
LIBRARY_FILESYSTEM_DIR:=filesystem-libs
# Public targets ###############################################################
.PHONY: $(MACHINE_LIBRARY_NAME_LIST)

# Create a template target to build a library
define BUILD_RECIPE
$(1): $(2)
	$(V)$(MAKE) $(1)
	$(V)$(MAKE) $(1) install
endef

# Create a template target to clean a library
define CLEAN_RECIPE
clean-$(1):
	$(V)$(MAKE) $(1) clean
endef

LIB_CLEAN_TARGET_LIST:=$(MACHINE_LIBRARY_NAME_LIST:%=clean-%)

# Disable targets if MACHINE_LIBRARY_NAME_LIST is not defined
ifdef MACHINE_LIBRARY_NAME_LIST
all: libraries-header libraries-filesystem $(MACHINE_LIBRARY_NAME_LIST)
else
all: libraries-header
endif

clean: libraries-header $(LIB_CLEAN_TARGET_LIST)
	@$(ECHO) "${MSG_INFO}  Clean Libraries ${MSG_END}"
	@$(ECHO) "${MSG_REQ}You need super user permissions to clean libraries${MSG_END}"
	$(V) sudo $(RM) ${COMMON_LIB_MACHINE_LIBS_DIR} ${COMMON_LIB_HOST_LIBS_DIR} \
	libraries-install libraries-filesystem
	$(V) sudo $(RM) ${LIBRARY_FILESYSTEM_DIR}

# Alias target to install linux
install: libraries-header libraries-install

uninstall: libraries-header
	@$(ECHO) "${MSG_INFO}  Uninstall libraries${MSG_END}"
	$(V) $(RM) libraries-install

# Build targets
$(info $(foreach i,$(MACHINE_LIBRARY_NAME_LIST),$(eval $(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi )))))

# Clean targets
$(info $(foreach i,$(MACHINE_LIBRARY_NAME_LIST),$(eval $(call CLEAN_RECIPE,$(i)))))

# Private targets ###############################################################

libraries-header:
	@$(ECHO) "${MSG_INFO}Libraries${MSG_END}"
# Create directories to store the libraries generated
	$(V) $(MKDIR) $(PRJ_ROOT_PATH)/libraries/$(COMMON_LIB_MACHINE_LIBS_DIR)
	$(V) $(MKDIR) $(PRJ_ROOT_PATH)/libraries/$(COMMON_LIB_HOST_LIBS_DIR)

libraries-filesystem:
ifdef MACHINE_LIBRARY_FILESYSTEM_DEP
	@$(ECHO) "${MSG_INFO}  Libraries import from filesystem${MSG_END}"
	@$(ECHO) "${MSG_REQ}You need super user permissions to import libraries${MSG_END}"
	$(V) $(MKDIR) $(PRJ_ROOT_PATH)/libraries/${LIBRARY_FILESYSTEM_DIR}
# Import libraries from the filesystem
	$(V) sudo ${CP} $(PRJ_ROOT_PATH)/filesystem/${MACHINE_FILESYSTEM_PKG_NAME}/${MACHINE_LIBRARY_FILESYSTEM_DEP} $(PRJ_ROOT_PATH)/libraries/${LIBRARY_FILESYSTEM_DIR}/
# Install libraries into build and host directories
	$(V) sudo $(PRJ_ROOT_PATH)/system-build/scripts/autotools-lib-installer.sh \
        --host-prefix ${PRJ_ROOT_PATH}/libraries/${COMMON_LIB_HOST_LIBS_DIR} \
        --libs-path ${MACHINE_LIBRARY_MACHINE_INSTALLDIR} \
        --libsrc-path $(PRJ_ROOT_PATH)/libraries/${LIBRARY_FILESYSTEM_DIR}/ \
        --boarddest-path $(PRJ_ROOT_PATH)/libraries/$(COMMON_LIB_MACHINE_LIBS_DIR) \
        --hostdest-path $(PRJ_ROOT_PATH)/libraries/$(COMMON_LIB_HOST_LIBS_DIR)
	$(V) touch $@
endif

libraries-install: libraries-filesystem
	@$(ECHO) "${MSG_INFO}  Libraries install${MSG_END}"
	@$(ECHO) "${MSG_REQ}You need super user permissions to install libraries${MSG_END}"
	$(V) cd board-libs; sudo find . | sudo cpio -pdum ${LIBRARY_INSTALLATION_PATH}

libraries-debug-targets:
# The lines must be coherent with the lines used in order to show the real recipes
	@echo $(info $(foreach i,$(MACHINE_LIBRARY_NAME_LIST),$(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi ))))
	@echo $(info $(foreach i,$(LIB_CLEAN_TARGET_LIST),$(call CLEAN_RECIPE,$(i))))

libraries-debug-var:
	@echo "MACHINE_LIBRARY_NAME_LIST: $(MACHINE_LIBRARY_NAME_LIST)"
	@echo "LIB_CLEAN_TARGET_LIST: $(LIB_CLEAN_TARGET_LIST)"
