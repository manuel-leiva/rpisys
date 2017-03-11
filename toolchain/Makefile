
.PHONY: all clean


# Include local definition
include ../Make.defs


all: sys-toolchain-uncomp

$(DOWNLOADDIR)/$(TOOLCHAIN_NAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	$(V) wget $(TOOLCHAIN_DLURL)/$(TOOLCHAIN_NAMETAR) -P $(DOWNLOADDIR)

sys-toolchain-uncomp: $(DOWNLOADDIR)/$(TOOLCHAIN_NAMETAR)
	@$(ECHO) "${MSG_INFO}  Uncompress toolchain${MSG_END} "
	$(V) mkdir -p $(COMMONDIR)
	$(V) tar -xf $(DOWNLOADDIR)/$(TOOLCHAIN_NAMETAR) -C $(COMMONDIR)
	$(V) touch sys-toolchain-uncomp


clean:
	$(V) rm sys-toolchain-uncomp
