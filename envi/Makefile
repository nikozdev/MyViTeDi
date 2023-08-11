vProjName:=MyViTeDi
vProjVnum:=1.0.0

vFileRoot:=..
vFileCode:=$(vFileRoot)/code
vFileDest?=$(HOME)
ifeq ($(vFileDestRoot),)
vFileDestRoot:=$(UserProfile)
endif
ifeq ($(vFileDestRoot),)
$(info failed destination resolution)
endif

vCmdCp:=cp -riv
vCmdRm:=rm -riv

print:
	$(info "[vProjName]=$(vProjName))
	$(info "[vProjVnum]=$(vProjVnum))
	$(info "[vFileRoot]=$(vFileRoot))
	$(info "[vFileCode]=$(vFileCode))
	$(info "[vFileDest]=$(vFileDest))

setup:
	$(vCmdCp) $(vFileCode)/config/* $(vFileDest)/.config/nvim
	$(vCmdCp) $(vFileCode)/shared/* $(vFileDest)/.local/share/nvim

reset:
#	$(vCmdRm) $(vFileDest)/.config/nvim $(vFileDest)/.local/share/nvim
	$(info "we do not have a clean way to reset $(vProjName)")
