
.PHONY: all clean


# Include local definition
include ../Make.defs


all: sys-toolchain-uncomp

$(DOWNLOADDIR)/$(TOOLCHAINNAMETAR):
	@$(ECHO) "${MSG_INFO}  Download toolchain${MSG_END} "
	#$(V) wget $(TOOLCHAINURL)/$(TOOLCHAINNAMETAR) -P $(DOWNLOADDIR)

sys-toolchain-uncomp: $(DOWNLOADDIR)/$(TOOLCHAINNAMETAR)
	@$(ECHO) "${MSG_INFO}  Uncompress toolchain${MSG_END} "
	$(V) mkdir -p $(COMMONDIR)
	$(V) tar -xf $(DOWNLOADDIR)/$(TOOLCHAINNAMETAR) -C $(COMMONDIR)
	$(V) touch sys-toolchain-uncomp


clean:
	$(V) rm sys-toolchain-uncomp
