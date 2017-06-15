
.PHONY: all clean


# Include local definition
include ../board.defs
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

all: toolchain-uncomp

$(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	$(V) wget $(TOOLCHAIN_DLURL)/$(TOOLCHAIN_NAMETAR) -P $(PRJ_DOWNLOAD_PATH)

toolchain-uncomp: $(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR)
	@$(ECHO) "${MSG_INFO}  Uncompress toolchain${MSG_END} "
	$(V) mkdir -p $(PRJ_COMMON_PATH)
	$(V) tar -xf $(PRJ_DOWNLOAD_PATH)/$(TOOLCHAIN_NAMETAR) -C $(PRJ_COMMON_PATH)
	$(V) touch sys-toolchain-uncomp


clean:
	$(V) rm toolchain-uncomp
