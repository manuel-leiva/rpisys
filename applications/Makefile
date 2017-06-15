include ../board.defs
# Include common recipes and definitions
include ../system-build/makefile/Makefile.common

all: applications-header

clean: applications-header applications-clean

install: applications-header applications-install

uninstall: applications-header applications-uninstall


# Private targets ##############################################################

applications-clean:
	@$(ECHO) "${MSG_INFO}  Remove applications${MSG_END}"

applications-header:
	@$(ECHO) "${MSG_INFO}Applications${MSG_END}"

applications-install:
	@$(ECHO) "${MSG_INFO}  Install applications${MSG_END}"
	touch $@

applications-uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall applications${MSG_END}"
	$(V) $(RM) applications-install
