
.PHONY: toolchain linux

toolchain:
	$(V)$(MAKE) toolchain all

linux: toolchain
	$(V)$(MAKE) linux all
