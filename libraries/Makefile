
include ../Make.defs

.PHONY: $(LIB_NAME_LIST)

define BUILD_RECIPE
$(1): $(2)
	$(V)$(MAKE) $(1)
	$(V)$(MAKE) $(1) install

endef


$(info $(foreach i,$(LIB_NAME_LIST),$(eval $(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi )))))

debug:
	@echo $(info $(foreach i,$(LIB_NAME_LIST),$(call BUILD_RECIPE,$(i),$(shell if [ -f $(i)/dependency.txt ]; then cat $(i)/dependency.txt ; fi ))))
