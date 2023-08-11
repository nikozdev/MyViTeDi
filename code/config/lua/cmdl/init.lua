--cmdl.lua - command line

--[[
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
	pattern = "*",
	command = "map <buffer> <F5> <CR>q:",
})
--]]
--vim.cmd(":autocmd CmdwinEnter [:>] map <buffer> <C-m> <CR>q:")

--endf
