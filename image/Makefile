
# Include local definition
include ../Make.defs

all: header install

clean:
	@$(ECHO) "${MSG_INFO}  Clean image${MSG_END} "
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/bootloader   uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/linux        uninstall
#~ 	$(V)$(MAKE) ${PRJ_ROOT_PATH}/filesystem   uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/libraries    uninstall
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/applications uninstall


header:
	@$(ECHO) "${MSG_INFO}Image build${MSG_END}"

install:
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/bootloader install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/linux install
#~ 	$(V)$(MAKE) ${PRJ_ROOT_PATH}/filesystem install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/libraries install
	$(V)$(MAKE) ${PRJ_ROOT_PATH}/applications install

sd: install
	@$(ECHO) "${MSG_INFO}  Build SD${MSG_END}"
	$(V) $(PRJ_ROOT_PATH)/system-build/scripts/make-image.sh -d /dev/mmcblk0 -f image/rootfs -b image/boot
