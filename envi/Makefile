NAME:=vimotedi

SROOT:=.
TROOT:=$(HOME)

CP:=cp -rivu
RM:=rm -riv

print:
	$(info "[SROOT]=$(SROOT))
	$(info "[TROOT]=$(TROOT))

setup:
	$(CP) $(SROOT)/config $(TROOT)/.config/nvim
	$(CP) $(SROOT)/shared $(TROOT)/.local/share/nvim

reset:
#	$(RM) $(TROOT)/.config/nvim $(TROOT)/.local/share/nvim
	$(info "we do not have a clean way to reset $(NAME)")
