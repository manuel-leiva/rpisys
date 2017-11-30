# Include board definition
include ../board.defs
# Include local configuration
include ../system-build/makefile/Makefile.local
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Definitions ##################################################################
## Local definitions ##
IMAGE_PATH:=${PRJ_ROOT_PATH}/image

# Public targets ###############################################################
all: image-header image-make

clean: image-header image-clean

sd: image-header image-make-sd

# Private targets ##############################################################

image-header:
	@$(ECHO) "${MSG_INFO}Image${MSG_END}"

image-download:
ifdef BOARD_IMAGE_TAR_NAME
	@$(ECHO) "${MSG_INFO}  Download${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/download-package.sh \
    --pkg-name ${BOARD_IMAGE_PKG_NAME} \
    --pkg-target-name ${BOARD_IMAGE_TAR_NAME} \
    --dl-path ${BOARD_PRJ_DOWNLOAD_PATH} \
    --dl-url ${BOARD_IMAGE_DL_URL} \
    --sha1sum ${BOARD_IMAGE_SHA1SUM}
endif
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
	$(V) touch $@

image-make-sd:
	@$(ECHO) "${MSG_INFO}  Build SD image${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/make-image.sh -d /dev/mmcblk0 -f image/rootfs -b image/boot

image-clean:
	@$(ECHO) "${MSG_INFO}  Remove image${MSG_END}"
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to remove the image${MSG_END}"
	$(V) sudo $(RM) image
