-- [[ neovim config by nikozdev

-- [=[ command line

vim.opt["shell"] = vim.env["SHELL"]

vim.opt["cmdheight"] = 4

vim.opt["history"] = 256

--]=]

-- [=[ visual

vim.cmd("colorscheme nord")

vim.opt["title"] = true
vim.opt["splitright"] = true

vim.opt["mousehide"] = true

vim.opt["visualbell"] = true

vim.opt["lazyredraw"] = true

--[==[ manage views

vim.cmd([[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.py mkview
    autocmd BufWinEnter *.py silent! loadview
    autocmd BufWinLeave *.cpp mkview
    autocmd BufWinEnter *.cpp silent! loadview
    autocmd BufWinLeave *.hpp mkview
    autocmd BufWinEnter *.hpp silent! loadview
    autocmd BufWinLeave *.lua mkview
    autocmd BufWinEnter *.lua silent! loadview
  augroup END
]])

--]==]

--]=]

-- [=[ navigation

vim.cmd("filetype on")

vim.g["netrw_bufsettings"] = "number relativenumber wrap ro"
vim.g["netrw_liststyle"] = 3

vim.opt["ruler"] = true
vim.opt["number"] = true
vim.opt["relativenumber"] = true

vim.opt["cursorline"] = true
vim.opt["cursorcolumn"] = true
vim.opt["cursorbind"] = false

vim.opt["scrollbind"] = false
vim.opt["scrolloff"] = 1024

vim.opt["colorcolumn"] = "80"
vim.opt["signcolumn"] = "yes"

--]=]

-- [=[ editing

vim.cmd("syntax enable")

--do not make backup files
vim.opt["backup"] = false
--do not add the end of the line for explicity
vim.opt["fixendofline"] = false

--do not make backup files
vim.opt["clipboard"] = "unnamedplus"

--do not turn spaces into tabs
vim.opt["expandtab"] = true
--tabbing moves 4 spaces
vim.opt["tabstop"] = 2
--how many spaces to use in auto indent
vim.opt["shiftwidth"] = 2

-- [==[ c-program indentation

--[===[
same indnent for every next line;
matching characters like {} have the same indentation;
--]===]
vim.opt["autoindent"] = false

--[===[
same as autoindent
respects cinwords
--]===]
vim.opt["smartindent"] = false
--[===[
configuration of all cin* options
- remove all identations if
> - line starts with #
> - line starts with label or  keyword followed by :
> > other than "case" or "default"
--]===]
vim.opt["cindent"] = true
--[===[
this is the set of rules to reindent a line
special keys:
^ - control characters
<> - spelled-out names of keys
o - <cr> anywhere or use "o" command in normal mode
O - use "O" command in normal mode
e - type second e for an "else" at the start of a line
=word - reindent when typing the last character of "word"
0=word - reindent only when there is white space before "word"
=~word - "=word" ignoring case
modifiers:
0<key> - reindent if <key> is the first character on a line
!<key> - do not insert <any> but reindent
*<key> - reindent before insert
--]===]
vim.opt["cinkeys"] = "0{,0},0(,0),0[,0],0#,:,;,*<cr>,o,O,e,!^f"
vim.opt["cinwords"] = "if,else,while,do,for,switch,typedef,namespace,struct,class"
--[===[
the default is... 
s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,N0,E0,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#0,P0
--]===]
vim.opt["cinoptions"] = ">s,g0,hs,N-s,t-s,ps,E0,is,+s,cs,C1,/0,:s,=s,l0,b0,(s,)64,us,U1,+0,m1,M0,^0,L0,j1,J1,*128,#0,P0"
--vim.opt["cinoptions"] = "s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,N>,E0,ps,ts,is,+0,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#0,P0"
vim.opt["cinscopedecls"] = "public,private,protected"
vim.opt["indentexpr"] = ""

--]==]

-- auto complete menu;
vim.opt["wildmenu"] = true
-- make auto complete menu behave like a zsh completion;
vim.opt["wildmode"] = "list:full"
-- do not auto complete these;
vim.opt["wildignore"] = { "*/cache/*", "*/tmp/*", "*/.git/*" }

vim.opt["showmatch"] = true
-- (0.1 * n) of a second to show the matching;
vim.opt["matchtime"] = 2

--]=]

-- [=[ completion

vim.opt["complete"] = { ".", "w", "b", "u", "t", }
vim.opt["completeopt"] = { "menu", "menuone", "noselect", }

--]=]

-- [=[ search/replace

--search highlighting
vim.opt["hlsearch"] = true
--update search during the typing
vim.opt["incsearch"] = true
--do not affect search by capital/regular case
vim.opt["ignorecase"] = true

--]=]

-- [=[ plugins

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
Plug 'vim-scripts/restore_view.vim'
Plug 'folke/which-key.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'czheo/mojo.vim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'ellisonleao/glow.nvim'
Plug 'RaafatTurki/hex.nvim'

Plug 'mfussenegger/nvim-dap'

Plug 'vimwiki/vimwiki'

]])
vim.call("plug#end")

require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		layout_config = {
			horizontal = {
				anchor = "E",
				width = 0.95,
				height = 0.95,
				preview_width = 0.5,
				preview_cutoff = 16,
			},
			vertical = {
				anchor = "E",
				width = 0.95,
				height = 0.95,
			},
			cursor = {
				anchor = "E",
				width = 0.95,
				height = 0.95,
			},
			flex = {
				anchor = "E",
				width = 0.95,
				height = 0.95,
			},
		}, --layout_config
	}, --defaults
  pickers = {
    find_files = { no_ignore = true },
  },
})

require("treesitter-context").setup({
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit
  min_window_height = 8, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 8, -- Maximum number of lines to show for a single context
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = "-",
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

require("lualine").setup({
  options = {
    theme = "nord",
    icons_enabled = false,
    section_separators = {
      left = "",
      right = "",
    }, --section_separators
    component_separators = {
      left = "",
      right = "",
    }, --component_separators
    disabled_filetypes = {
    }, --disabled_filetypes
    always_divide_middle = true,
    globalstatus = false,
  }, --options
  sections = {
    lualine_a = { "filetype", { "filename", path = 0 }, },
    lualine_b = { "location", "progress", },
    lualine_c = {
      { "mode", fmt = function(str) return "m"..str:sub(1,1) end },
      { "winnr", fmt = function(str) return "w"..str end },
    },
    lualine_x = {
      { "winnr", fmt = function(str) return str.."w" end },
      { "mode", fmt = function(str) return str:sub(1,1).."m" end },
    },
    lualine_y = { "progress","location", },
    lualine_z = { { "filename", path = 0 }, "filetype", },
  }, --sections
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }, --inactive_sections
  tabline = {
  }, --tabline
  extensions = {
  }, --extensions
})

--[==[ completion

local pCmp = require("cmp")

pCmp.setup({

    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)

        end
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<c-space>"] = cmp.mapping.complete({}),
        ["<c-b>"] = cmp.mapping.scroll_docs(0-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(0+4),
        ["<c-k>"] = cmp.mapping.select_prev_item({}),
        ["<c-j>"] = cmp.mapping.select_next_item({}),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<s-tab>"] = cmp.mapping.select_prev_item({}),
        ["<tab>"] = cmp.mapping.select_next_item({}),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({

        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "vsnip" },

    }),

})

pCmp.setup.cmdline("/", {

    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },

})

pCmp.setup.cmdline(":", {

    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "path" },
        { name = "cmdline" },
    },

})

--]==]

require("glow").setup({
    glow_path = "/usr/bin/glow",
    install_path = "~/.local/bin",
    border = "shadow",
    style = "dark",
    pager = false,
    width = 80,
    height = 100,
    width_ratio = 0.75,
    height_ratio = 0.75,
})

-- [==[ debug

local pDap = require("dap")

pDap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/nikozdev/.local/share/"
    .. "cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

pDap.setupCommands = {
}

pDap.configurations.cpp = {
    {
        name = "launch",
        type = "cppdbg",
        request = "launch",
        program = function()
            local prompt = vim.fn.getcwd() .. "/bin/"
            return vim.fn.input("execpath: ", prompt, "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
    },
    {
        name = "attach",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        program = function()
            local prompt = vim.fn.getcwd() .. "/bin/"
            return vim.fn.input("execpath: ", prompt, "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

--]==]

require("hex").setup({})

require('restore_view').setup({})

--]=]

-- [=[ language server protocol

local pLspConfig = require("lspconfig")
local pLspConfigTable = require("lspconfig.configs")
local pLspConfigUtils = require("lspconfig.util")

local vEnVarHome = os.getenv("HOME")
local vEnVarConf = vEnVarHome .. "/.config"
local vEnVarNvim = vEnVarConf .. "/nvim"

local vPackageFpath = vim.split(package.path, ";")
table.insert(vPackageFpath, "lua/?.lua")
table.insert(vPackageFpath, "lua/?/init.lua")

local vLspLuaFpath = vim.fn.exepath("lua-language-server")
local vLspLuaDpath = vim.fn.fnamemodify(vLspLuaFpath, ":h:h:h")

local vLspCaps = nil
pcall(function()
  local vCmpNvimLsp = require('cmp_nvim_lsp')
  local vNvimCaps = vim.lsp.protocol.make_client_capabilities()
  --vLspCaps = comp.update_capabilities(nvim_caps)
  vLspCaps = comp.default_capabilities(nvim_caps)
end)

local function fRunLspSetup(vName, vConfigTable)
  vConfigTable = vConfigTable or {}
  vConfigTable.capabilities = vLspCaps
  
  --[===[
  call this code
  only when ls is attached
  --]===]
  local fForLspAttach function(vClient, vBufferIndex)
      -- see `:help vim.lsp.*`
      local vOptionTable = { noremap = true, silent = true, buffer = vBufferIndex }

      vim.keymap.set('n','gd', vim.lsp.buf.definition, vOptionTable)
      vim.keymap.set('n','gD', vim.lsp.buf.declaration, vOptionTable)
      vim.keymap.set('n','gi', vim.lsp.buf.implementation, vOptionTable)

      vim.keymap.set('n','<c-l><c-n>', vim.lsp.buf.rename, vOptionTable)
      vim.keymap.set('n','<c-l><c-r>', vim.lsp.buf.references, vOptionTable)
      vim.keymap.set('n','<c-l><c-h>', vim.lsp.buf.hover, vOptionTable)
      vim.keymap.set('n','<c-l><c-s>', vim.lsp.buf.signature_help, vOptionTable)
      vim.keymap.set('n','<c-l><c-d>', vim.diagnostic.open_float, vOptionTable)
      vim.keymap.set('n','<c-l><c-f>', vim.lsp.buf.formatting, vOptionTable)
    end
  fForLspAttachWas = vConfigTable.on_attach
  if fForLspAttachWas then
    vConfigTable.on_attach = function(vClient, vBufferIndex)
      fForLspAttach(vClient, vBufferIndex)
      fForLspAttachWas(vClient, vBufferIndex)
    end
  else
    vConfigTable.on_attach = fForLspAttach
  end

  local vSuccess, vMessage = pcall(pLspConfigTable[vName].setup, vConfigTable)
  if not vSuccess then
    print(vMessage)
  end
end

require("mason").setup({})
require("mason-lspconfig").setup({
  automatic_installation = false,
  ensure_installed = {
    "marksman",
    "clangd",
  },
})

fRunLspSetup("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh", },
})

fRunLspSetup("marksman", {})
fRunLspSetup("html", {})

fRunLspSetup("clangd", {
  cmd = { "clangd", "--enable-config", "--compile-commands-dir=./make", },
  filetypes = { "c", "cpp", "cxx", "h", "hpp", "hxx", },
  settings = { arguments = { "enable-config" }, },
  on_attach = function(client, bufnum)
    on_attach(client, bufnum)
    local bufopt = { noremap = true, silent = true, buffer = bufnum }
    vim.keymap.set('n','<c-l><c-f>', function()
      vim.cmd[[! clang-format --style=file:./envi/clang-format.yaml -i %]]
    end, bufopt)
  end
})

fRunLspSetup("pyright", {})

--[==[
fRunLspSetup("sumneko_lua", {
  --[[
  cmd = {
    lsp_lua_bin,
    "-E",
    lsp_lua_dir .. "/main.lua"
  },
  --]]

  settings = {
    Lua = {

      runtime = {
        version = "LuaJIT",
        path = rtpath,
      },
      diagnostics = {
        -- recognize these globals
        globals = {
          "vim"
        },
      },
      workspace = {
        -- be aware of the neovim runtime libs
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      },

    },
  },

  on_attach = function(client, bufnum)

    on_attach(client, bufnum)

    local clients = vim.lsp.buf_get_clients()
    if #clients > 0 then
      for index, bufclient in pairs(clients) do
        if bufclient == client then
          bufclient.stop()
        end
      end
    end

    local bufopt = { noremap = true, silent = true, buffer = bufnum }
    vim.keymap.set('n','<c-l><c-f>', function()
      vim.cmd[[! stylua -f stylua.toml %]]
    end, bufopt)

  end,

})
--]==]

fRunLspSetup("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})

require("rust-tools").setup({
  server = {
    on_attach = function(client, bufnum)
      on_attach(client, bufnum)
    end,
  },
})

fRunLspSetup("gopls", { })

local mojo_ls = {
  "czheo/mojo.vim",
  ft = { "mojo" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "*.mojo" },
      callback = function()
        if vim.bo.filetype ~= "mojo" then
          vim.bo.filetype = "mojo"
        end
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "mojo",
      callback = function()
        local modular = vim.env.MODULAR_HOME
        local lsp_cmd = modular .. "/pkg/packages.modular.com_mojo/bin/mojo-lsp-server"

        vim.bo.expandtab = true
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4

        vim.lsp.start({
          name = "mojo",
          cmd = { lsp_cmd },
        })
      end,
    })
  end,
}
mojo_ls.init()

fRunLspSetup("tsserver", { })

--]=]

-- [=[ key mapping for all modes

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [==[ normal mode

vim.keymap.set("n", "u", "<cmd>undo<cr>", {
  ["remap"] = false,
  ["desc"] = "revert the last action",
})
vim.keymap.set("n", "U", "<cmd>redo<cr>", {
  ["remap"] = false,
  ["desc"] = "revert the last undo",
})

vim.keymap.set("n", "<c-w><c-e>", "<cmd>Explore<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of explorer",
})
vim.keymap.set("n", "<c-w><c-e>", "<cmd>Explore<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of explorer",
})
vim.keymap.set("n", "<c-w><c-t>", "<cmd>split term://$SHELL<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of terminal",
})
vim.keymap.set("n", "<c-w>t", "<cmd>split term://$SHELL<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of terminal",
})

vim.keymap.set("n", "fc", "<cmd>Telescope commands<cr>", {
  ["remap"] = false,
  ["desc"] = "fuzzy find a command",
})
vim.keymap.set("n", "ff", "<cmd>Telescope find_files hidden=true<cr>", {
  ["remap"] = false,
  ["desc"] = "fuzzy find a file",
})
vim.keymap.set("n", "fe", "<cmd>Telescope live_grep hidden=true<cr>", {
  ["remap"] = false,
  ["desc"] = "fuzzy find an expression in files",
})
vim.keymap.set("n", "fb", "<cmd>Telescope buffers<cr>", {
	["remap"] = false,
	["desc"] = "fuzzy find an openned buffer",
})
vim.keymap.set("n", "fgf", "<cmd>Telescope git_files<cr>", {
	["remap"] = false,
	["desc"] = "fuzzy find a file in git",
})
vim.keymap.set("n", "fgc", "<cmd>Telescope git_commits<cr>", {
	["remap"] = false,
	["desc"] = "fuzzy find a commit in git",
})
vim.keymap.set("n", "fk", "<cmd>Telescope keymaps<cr>", {
	["remap"] = false,
	["desc"] = "fuzzy find keymaps",
})

vim.keymap.set("n", "T", "<cmd>tabnew<cr>", {
  ["remap"] = false,
  ["desc"] = "open a new tab",
})
vim.keymap.set("n", "gt", "<cmd>tabn<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the next tab",
})
vim.keymap.set("n", "gT", "<cmd>tabp<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the prev tab",
})

vim.keymap.set("n", "gb", "<cmd>bn<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the next buffer",
})
vim.keymap.set("n", "gB", "<cmd>bp<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the prev buffer",
})

vim.keymap.set("n", "!", ":! ", {
  ["remap"] = false,
  ["desc"] = "switch to the prev buffer",
})

--]==]

-- [==[ command mode
--]==]

-- [==[ visual mode
--]==]

-- [==[ insert mode
--]==]

-- [==[ terminal mode

vim.keymap.set("t","<c-]>","<c-\\><c-n>",{
    ["desc"]="switch from terminal to normal mode"
})

--]==]

--]=]

--]]
