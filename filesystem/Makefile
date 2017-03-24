.PHONY: all clean header

# Include local definition
include ../Make.defs

# Local definitions

FILESYSTEM_DIR:=$(shell pwd)

all: header sys-filesystem-install

header:
	@$(ECHO) "${MSG_INFO}Filesystem build${MSG_END} "

$(DOWNLOADDIR)/$(FILESYSTEM_NAMETAR):
	@$(ECHO) "${MSG_INFO}  Download rootfs${MSG_END} "
	$(V) wget $(FILESYSTEM_DLURL)/$(FILESYSTEM_NAMETAR) -P $(DOWNLOADDIR)

sys-filesystem-uncomp: $(DOWNLOADDIR)/$(FILESYSTEM_NAMETAR)
	@    $(ECHO) "${MSG_INFO}  Uncompress rootfs ${MSG_END}"
	$(V) $(MKDIR) $(COMMONDIR)
	$(V) tar -xf $(DOWNLOADDIR)/$(FILESYSTEM_NAMETAR)
	$(V) touch $@

clean: header
	@$(ECHO) "${MSG_INFO}  Remove linux${MSG_END}"
	$(V) $(RM) sys-filesystem-*

install:



debug:
