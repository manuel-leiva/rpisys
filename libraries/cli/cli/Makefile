################################################################################
# Makefile
#
# Builds library and tests
#
# Author: Manuel Leiva
#
################################################################################

.PHONY: all clean help lib lib-clean test test-clean dep

# Include local definition
include board.defs

# List of path for each include public file
INCINSTALLSRC = $(addprefix $(INCDIR)/,$(PUBINCFILES))

# RULES ########################################################################

all: lib test
	@echo "$(MSG_INFO)$(LIBNAME) library project created$(MSG_END)"

clean: lib-clean test-clean

clean-all: clean install-clean

dep:
	$(V)$(MAKE) $(DEPDIR)

lib:
	$(V)$(MAKE) $(SRCDIR)

lib-clean:
	$(V)$(MAKE) $(SRCDIR) clean

test:
	$(V)$(MAKE) $(TESTDIR)

test-clean:
	$(V)$(MAKE) $(TESTDIR) clean

test-run:
	$(V)$(MAKE) $(TESTDIR) run

install: lib
	$(V)mkdir -p $(INSTLIBDIR)
	$(V)mkdir -p $(INSTALLINCDIR)
	$(V)cp $(INSTLIBDIR)/lib$(LIBNAME).a $(DESTDIR)/$(LIBDIR)/
	$(V)cp $(INCINSTALLSRC) $(INSTALLINCDIR)/
	@echo "$(MSG_INFO)$(LIBNAME) library installed$(MSG_END)"

install-clean:
	$(V)rm -f $(LIBDIR)/lib$(LIBNAME).a

help:
	@echo -e "\n$(LIBNAME) library\n"
	@echo "Make targets:"
	@echo "   all           Build library and tests"
	@echo "   lib           Build library"
	@echo "   test          Build tests"
	@echo "   test-run      Run tests"
	@echo "   clean         Delete all derived files"
	@echo "   install       Install header and library files"
	@echo "Make parameters:"
	@echo "   DEBUG=1       Produce debugging information in the operating system's native"
	@echo "                 (GDB can work with this debugging information)"
	@echo "   VERBOSE=1     Show executing commands"

debug-var:
	@echo "Compiler:         $(CC)"
	@echo "Compiler flags:   $(CFLAGS)"
	@echo "Compiler include: $(INCDIRLIST)"
	@echo "pwd:              $(PWDDIR)"
	@echo "nm:               $(NM)"
	@echo "Public include files: $(INCINSTALLSRC)"
	@echo "Info: $(MSG_INFO)Info$(MSG_END)"
	@echo "Debug: $(MSG_DEBUG)Debug$(MSG_END)"
