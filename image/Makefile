
# Include local definition
include ../board.defs
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

# Public targets ###############################################################
all: image-header image-make

clean: image-header image-clean

sd: image-header image-make-sd

# Private targets ##############################################################

image-header:
	@$(ECHO) "${MSG_INFO}Image${MSG_END}"

image-make:
	@$(ECHO) "${MSG_INFO}  Build image${MSG_END}"

image-make-sd:
	@$(ECHO) "${MSG_INFO}  Build SD image${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/make-image.sh -d /dev/mmcblk0 -f image/rootfs -b image/boot

image-clean:
	@$(ECHO) "${MSG_INFO}  Remove image${MSG_END}"
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/bootloader   uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/linux        uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/filesystem   uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/libraries    uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/applications uninstall
	@$(ECHO) "${MSG_REQ}You need to be logged in as root you to remove the image${MSG_END}"
	$(V) sudo $(RM) image
