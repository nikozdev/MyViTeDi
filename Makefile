vProjName:=MyViTeDi
vProjVnum:=2.0.0

print:
	$(info "[vProjName]=$(vProjName))
	$(info "[vProjVnum]=$(vProjVnum))
	$(info "[vFileDest]=$(vFileDest))

setup:
	cp -riv ./init.lua $(XDG_CONFIG_HOME)/nvim/init.lua

reset:
#	rm -riv $(XDG_CONFIG_HOME)/nvim/init.lua
	$(info "we do not have a clean way to reset $(vProjName)")

reget:
	cp -riv $(XDG_CONFIG_HOME)/nvim/init.lua ./init.lua
