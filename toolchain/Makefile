
.PHONY: all clean


# Include local definition
include ../Make.defs

all: sys-toolchain-uncomp

$(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	$(V) wget $(TOOLCHAIN_DLURL)/$(TOOLCHAIN_NAMETAR) -P $(PRJ_DOWNLOAD_PATH)

sys-toolchain-uncomp: $(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR)
	@$(ECHO) "${MSG_INFO}  Uncompress toolchain${MSG_END} "
	$(V) mkdir -p $(PRJ_COMMON_PATH)
	$(V) tar -xf $(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR) -C $(PRJ_COMMON_PATH)
	$(V) touch sys-toolchain-uncomp


clean:
	$(V) rm sys-toolchain-uncomp
