--lua/keys/init.lua - key mapping for all modes

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("keys.n")
require("keys.c")
require("keys.v")
require("keys.i")
require("keys.t")

--endf
