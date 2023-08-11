--lua/opts/edit.lua - editing options

vim.cmd("syntax enable")

--do not make backup files
vim.opt["backup"] = false
--do not add the end of the line for explicity
vim.opt["fixendofline"] = false

--do not turn spaces into tabs
vim.opt["expandtab"] = true
--same indentation on the next line
vim.opt["autoindent"] = true
--tabbing moves 4 spaces
vim.opt["tabstop"] = 2
--how many spaces to use in auto indent
vim.opt["shiftwidth"] = 2
--custom tabs for other langs
vim.cmd([[ autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 ]])

--auto complete menu
vim.opt["wildmenu"] = true
--make auto complete menu behave like a zsh completion
vim.opt["wildmode"] = "list:full"
--do not auto complete these
vim.opt["wildignore"] = { "*/cache/*", "*/tmp/*" }

vim.opt["showmatch"] = true
--(0.1 * n) of a second to show the matching
vim.opt["matchtime"] = 2

--endf
