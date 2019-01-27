# Include board definition
include ../machine.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################

## Local definitions ##

ifndef BOARD_IMAGE_PARTITION0_DIR
IMAGE_PARTITION0_PATH=${COMMON_IMAGE_BOOT_PATH}
else
IMAGE_PARTITION0_PATH=${PRJ_ROOT_PATH}/image/$(BOARD_IMAGE_PARTITION0_DIR)
endif

ifndef BOARD_IMAGE_PARTITION1_DIR
IMAGE_PARTITION1_PATH=${COMMON_IMAGE_ROOTFS_PATH}
else
IMAGE_PARTITION1_PATH=${PRJ_ROOT_PATH}/image/$(BOARD_IMAGE_PARTITION1_DIR)
endif

## Exported variables ##
# Linux instalation paths
export IMAGE_PATH:=${PRJ_ROOT_PATH}/image

# Create parameter list to create image
ifdef BOARD_IMAGE_EXT_SD_DEVICE
IMAGE_MAKE_SCRIPT_PARAMS=-d ${BOARD_IMAGE_EXT_SD_DEVICE}
endif
ifdef IMAGE_PARTITION0_PATH
IMAGE_MAKE_SCRIPT_PARAMS+=-a ${IMAGE_PARTITION0_PATH}
endif
ifdef IMAGE_PARTITION1_PATH
IMAGE_MAKE_SCRIPT_PARAMS+=-b ${IMAGE_PARTITION1_PATH}
endif
ifdef BOARD_IMAGE_DISK_PARTITION_PATH
IMAGE_MAKE_SCRIPT_PARAMS+=-f ${BOARD_IMAGE_DISK_PARTITION_PATH}
endif
ifdef BOARD_IMAGE_PARTITION0_NAME
IMAGE_MAKE_SCRIPT_PARAMS+=--partition0-name ${BOARD_IMAGE_PARTITION0_NAME}
endif
ifdef BOARD_IMAGE_PARTITION1_NAME
IMAGE_MAKE_SCRIPT_PARAMS+=--partition1-name ${BOARD_IMAGE_PARTITION1_NAME}
endif

# Create parameter list to download the package
ifdef BOARD_IMAGE_PKG_NAME
IMAGE_DOWNLOAD_SCRIPT_PARAMS=--pkg-name ${BOARD_IMAGE_PKG_NAME}
endif
ifdef BOARD_IMAGE_PKG_NAME
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--pkg-target-name  ${BOARD_IMAGE_TAR_NAME}
endif
ifdef BOARD_PRJ_DOWNLOAD_PATH
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--dl-path ${BOARD_PRJ_DOWNLOAD_PATH}
endif
ifdef BOARD_IMAGE_DL_URL
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--dl-url ${BOARD_IMAGE_DL_URL}
endif
ifdef BOARD_IMAGE_SHA1SUM
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--sha1sum ${BOARD_IMAGE_SHA1SUM}
endif
ifdef BOARD_IMAGE_BRANCH
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--branch ${BOARD_IMAGE_BRANCH}
endif
ifdef BOARD_IMAGE_GIT_DEPTH
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--git-depth ${BOARD_IMAGE_GIT_DEPTH}
endif
ifdef BOARD_IMAGE_SU
IMAGE_DOWNLOAD_SCRIPT_PARAMS+=--su y
endif
# Public targets ###############################################################
all: image-header image-make

clean: image-header image-clean

sd: image-header image-make-sd

custom: image-header image-make-custom
# Private targets ##############################################################

image-header:
	@$(ECHO) "${MSG_INFO}Image${MSG_END}"

image-download:
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
ifdef BOARD_IMAGE_TAR_NAME
	@$(ECHO) "${MSG_INFO}  Download${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    ${IMAGE_DOWNLOAD_SCRIPT_PARAMS}
endif
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@


image-patch: image-download
# Call pre-patch recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
# Apply patch
	$(call COMMON_RECIPE_PATCH,$(IMAGE_PATH),${BOARD_IMAGE_PKG_NAME})
# Call post-patch recipe
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)
	$(V) touch $@


image-make: image-patch
	@$(ECHO) "${MSG_INFO}  Build image${MSG_END}"
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@)
	$(V) touch $@


image-make-sd:
	@$(ECHO) "${MSG_INFO}  Build SD image${MSG_END}"
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-pre)
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/make-image.sh ${IMAGE_MAKE_SCRIPT_PARAMS}
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)


image-make-custom:
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@)


image-clean:
	@$(ECHO) "${MSG_INFO}  Remove image${MSG_END}"
	@$(ECHO) "${MSG_REQ}You need super user permissions to clean image${MSG_END}"
	$(V) sudo $(RM) image
	$(V) sudo $(RM) image-download image-patch image-make
	$(call COMMON_RECIPE_HOOK,$(BOARD_PRJ_MAKEFILE_HOOKS_PATH),$@-post)

image-debug-var:
	@$(ECHO) "IMAGE_MAKE_SCRIPT_PARAMS=${IMAGE_MAKE_SCRIPT_PARAMS}"
	@$(ECHO) "IMAGE_DL_PKG_PARAMS=${IMAGE_DL_PKG_PARAMS}"
