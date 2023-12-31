--lua/plug/init.lua - plugin initializer

vim.opt["compatible"] = false

vim.call("plug#begin","~/.config/nvim/plug")
vim.cmd([[

Plug 'nvim-lua/plenary.nvim'

Plug 'junegunn/fzf', { 'do': 'fzf#install()' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'BurntSushi/ripgrep'

Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'simrat39/rust-tools.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'ellisonleao/glow.nvim'

Plug 'mfussenegger/nvim-dap'

Plug 'RaafatTurki/hex.nvim'

]])
vim.call("plug#end")

require("plug.find")
require("plug.line")
require("plug.comp")
require("plug.glow")
require("plug.dbug")
require("plug.heks")

--endf
