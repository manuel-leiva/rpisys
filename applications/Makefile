include ../board.defs

all: applications-header

install: applications-header applications-install

uninstall: applications-header applications-uninstall


# Private targets ##############################################################


applications-header:
	@$(ECHO) "${MSG_INFO}Applications${MSG_END}"

applications-install:
	@$(ECHO) "${MSG_INFO}  Install applications${MSG_END}"
	touch $@

applications-uninstall:
	@$(ECHO) "${MSG_INFO}  Uninstall applications${MSG_END}"
	$(V) $(RM) applications-install
