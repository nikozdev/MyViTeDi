-- [[ neovim config by nikozdev

local function fUpdLeader()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
end
fUpdLeader()

-- [=[ command line

vim.opt["shell"] = vim.env["SHELL"]

vim.opt["cmdheight"] = 4

vim.opt["history"] = 256

--]=]

-- [=[ visual

vim.cmd("colorscheme nord")

vim.opt.showtabline = 2

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

local vLazyFpath = vim.fn.stdpath("config") .. "/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(vLazyFpath) then
  local vLazyWpath = "https://github.com/folke/lazy.nvim.git"
  local vGitOutput = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", vLazyWpath, vLazyFpath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { vGitOutput, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(vLazyFpath)

vLazyPcallSuccess, vLazyPcallMessage = pcall(require("lazy").setup, {
  spec = {
    -- [==[ package management
    {
      "vhyrro/luarocks.nvim",
      lazy = false,
      priority = 1000,
      config = true,
    },
    --]==]
    -- [==[ languages
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      priority = 100,
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true,
          },
        })
      end,
    },
    {
      'neovim/nvim-lspconfig',
      lazy = false,
    },
    {
      'williamboman/mason.nvim',
      config = true,
      lazy = true,
      cmd = "Mason",
    },
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = true,
      lazy = true,
      cmd = "Mason",
      dependencies = {
        'williamboman/mason.nvim',
      },
      config = function()
        require("mason-lspconfig").setup({
          automatic_installation = false,
          ensure_installed = {
            "marksman",
            "clangd",
          },
        })
        -- [=[ language server protocol

        local pLspConfig = require("lspconfig")
        local pLspConfigTable = require("lspconfig.configs")
        local pLspConfigUtils = require("lspconfig.util")

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
          local fForLspAttach = function(vClient, vBufferIndex)
            -- see `:help vim.lsp.*`
            local vOptionTable = { noremap = true, silent = true, buffer = vBufferIndex }

            fUpdLeader()

            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, vOptionTable)
            vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, vOptionTable)
            vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, vOptionTable)
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, vOptionTable)

            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, vOptionTable)
            vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, vOptionTable)
            vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, vOptionTable)

            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, vOptionTable)
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, vOptionTable)
          end
          local fForLspAttachWas = vConfigTable.on_attach
          if fForLspAttachWas ~= nil then
            vConfigTable.on_attach = function(vClient, vBufferIndex)
              fForLspAttach(vClient, vBufferIndex)
              fForLspAttachWas(vClient, vBufferIndex)
            end
          else
            vConfigTable.on_attach = fForLspAttach
          end

          vLspConfig = pLspConfig[vName]
          if vLspConfig then
            local vSuccess, vMessage = pcall(vLspConfig.setup, vConfigTable)
            if not vSuccess then
              vim.api.nvim_echo(vMessage)
            end
          else
            vim.api.nvim_echo("The LSP config \"" .. vName .. "\" was not found")
          end
        end

        --fRunLspSetup("marksman", { })
        fRunLspSetup("bashls", { })

        fRunLspSetup("html", { })

        fRunLspSetup("clangd", {
          cmd = { "clangd", "--enable-config", "--compile-commands-dir=./", },
          filetypes = { "c", "cpp", "cxx", "h", "hpp", "hxx", },
          settings = { arguments = { "enable-config" }, },
          on_attach = function(vClient, vBufferIndex)
            local vOptionTable = { noremap = true, silent = true, buffer = vBufferIndex }
            vim.keymap.set('n','<leader>lf', function()
              vim.cmd[[! clang-format --style=file:.clang-format -i %]]
            end, vOptionTable)

            vClient.handlers["textDocument/definition"] = function(_, result, ctx, config)
              if not result or vim.tbl_isempty(result) then
                return
              end
              if #result == 1 then
                vim.lsp.util.jump_to_location(result[1])
              else
                -- If multiple results, show a quickfix list
                vim.fn.setqflist({}, ' ', { title = 'LSP Definitions', items = result })
                vim.cmd('copen')
              end
            end
          end
        })

        fRunLspSetup("pyright", {})

        -- [==[
        fRunLspSetup("lua_ls", {
          settings = {
            Lua = {
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

          on_attach = function(vClient, vBufferIndex)

            local bufopt = { noremap = true, silent = true, buffer = vBufferIndex }
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
      end,
    },
    {
      'simrat39/rust-tools.nvim',
      enabled = false,
      lazy = true,
      ft = "rs",
      config = function()
        require('rust-tools').setup({
          server = {},
        })
      end,
    },
    {
      'czheo/mojo.vim',
      enabled = false,
      lazy = true,
      event = "VeryLazy",
      ft = "mojo",
    },
    {
      'mfussenegger/nvim-dap',
      enabled = true,
      lazy = true,
    },
    {
      "neoclide/coc.nvim",
      branch = "release",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        vim.g.coc_global_extensions = {
          "coc-snippets",
          "coc-pairs",
          "coc-tsserver",
          "coc-eslint",
          "coc-prettier",
          "coc-json",
        }
        vim.cmd [[
        inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

        nmap <silent> <leader>c[ <Plug>(coc-diagnostic-prev)
        nmap <silent> <leader>c] <Plug>(coc-diagnostic-next)

        nmap <silent> <leader>cd <Plug>(coc-definition)
        nmap <silent> <leader>ci <Plug>(coc-implementation)
        nmap <silent> <leader>cr <Plug>(coc-references)

        nnoremap <silent> <F3> :CocCommand clangd.switchSourceHeader<CR>
        ]]
      end,
    },
    --]==]
    -- [==[ navigation
    {
      'nvim-treesitter/nvim-treesitter-context',
      enabled = true,
      lazy = true,
      event = "VeryLazy",
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require("treesitter-context").setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 8, -- How many lines the window should span. Values <= 0 mean no limit
          min_window_height = 12, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
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
      end,
    },
    {
      'junegunn/fzf.vim',
      enabled = true,
      lazy = true,
      dependencies = {
        'BurntSushi/ripgrep',
        {
          'junegunn/fzf',
          build = 'fzf#install()',
        }
      },
    },
    {
      'nvim-telescope/telescope.nvim',
      enabled = true,
      lazy = true,
      event = "VeryLazy",
      dependencies = {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
        }
      },
      config = function()
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
            },
          },
          pickers = {
            find_files = {
              --find_command = { 'rg --files --hidden' },
              no_ignore = true,
            },
            live_grep = {
            }
          },
        })
      end,
      keys = function()
        local pTeleScopeBuiltIn = require('telescope.builtin')
        return {
          { '<leader>ff', pTeleScopeBuiltIn.find_files, desc = "fuzzy find a file;" },
          { '<leader>fe', pTeleScopeBuiltIn.live_grep, desc = "fuzzy find an expression in files;" },
          { '<leader>fb', pTeleScopeBuiltIn.buffers, desc = "fuzzy find an openned buffer;" },
          { '<leader>fc', pTeleScopeBuiltIn.commands, desc = "fuzzy find a command;" },
          { '<leader>fk', pTeleScopeBuiltIn.keymaps, desc = "fuzzy find keymaps;" },
          { '<leader>fg', pTeleScopeBuiltIn.git_commits, desc = "fuzzy find a git commit;" },
        }
      end
    },
    {
      "folke/which-key.nvim",
      lazy = true,
      event = "VeryLazy",
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer local keymaps (which-key)",
        },
      },
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'echasnovski/mini.nvim',
      },
    },
    --]==]
    -- [==[ completion
    {
      'hrsh7th/nvim-cmp',
      enabled = true,
      lazy = true,
      event = "BufEnter",
      config = function()
        local pCmp = require("cmp")
        pCmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end
          },
          window = {
            completion = pCmp.config.window.bordered(),
            documentation = pCmp.config.window.bordered(),
          },
          mapping = pCmp.mapping.preset.insert({
            ["<c-space>"] = pCmp.mapping.complete({}),
            ["<c-b>"] = pCmp.mapping.scroll_docs(0-4),
            ["<c-f>"] = pCmp.mapping.scroll_docs(0+4),
            ["<c-k>"] = pCmp.mapping.select_prev_item({}),
            ["<c-j>"] = pCmp.mapping.select_next_item({}),
            ["<c-e>"] = pCmp.mapping.abort(),
            ["<s-tab>"] = pCmp.mapping.select_prev_item({}),
            ["<tab>"] = pCmp.mapping.select_next_item({}),
            ["<cr>"] = pCmp.mapping.confirm({ select = true }),
          }),
          sources = pCmp.config.sources({
            { name = "buffer" },
            { name = "nvim_lsp" },
            { name = "vsnip" },
          }),
        })
        pCmp.setup.cmdline("/", {
          mapping = pCmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })
        pCmp.setup.cmdline(":", {
          mapping = pCmp.mapping.preset.cmdline(),
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
        })
      end,
      dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
      },
    },
    --]==]
    -- [==[ view
    {
      'nvim-lualine/lualine.nvim',
      enabled = true,
      config = function()
        require("lualine").setup({
          options = {
            theme = "nord",
            icons_enabled = true,
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
      end
    },
    {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
      init = function()
        vim.opt.termguicolors = true
      end,
      config = function()
        require('bufferline').setup({
          options = {
            numbers = "none", -- or "ordinal"
            close_command = "bdelete! %d", -- command to close the buffer
            right_mouse_command = "bdelete! %d", -- command for right mouse click
            indicator_icon = '▎',
            buffer_close_icon = 'x',
            modified_icon = '●',
            left_trunc_marker = '',
            right_trunc_marker = '',
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
              }
            },
          },
        })
      end,
    },
    {
      'famiu/bufdelete.nvim',
      enabled = true,
      lazy = true,
      event = "BufEnter",
    },
    {
      'vim-scripts/restore_view.vim',
      enabled = true,
      lazy = true,
      event = "VeryLazy",
    },
    --]==]
    -- [==[ specific formats
    {
      'ellisonleao/glow.nvim',
      enabled = false,
      lazy = true,
      config = function()
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
      end,
    },
    {
      'RaafatTurki/hex.nvim',
      enabled = true,
      lazy = true,
      event = "BufEnter",
    },
    --]==]
    -- [==[ organisation and productivity
    {
      "nvim-neorg/neorg",
      enabled = false,
      lazy = false,
      version = "*",
      dependencies = {
        "vhyrro/luarocks.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "kyazdani42/nvim-web-devicons",
      },
      rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim" },
      config = function()
        require("neorg").setup({
          load = {
            ['core.defaults'] = {},
            ['core.dirman'] = {
              config = {
                workspaces = {
                  Basic = '~/Other/neorg',
                },
              },
            },
          },
        })
      end,
    },
    {
      'nvim-orgmode/orgmode',
      enabled = true,
      lazy = true,
      ft = { 'org' },
      config = function()
        -- Setup orgmode
        require('orgmode').setup({
          org_agenda_files = vim.fn.stdpath('data') .. '/orgfiles/**/*',
          org_default_notes_file = vim.fn.stdpath("data") .. '/orgfiles/refile.org',
        })
      end,
    },
    {
      'vimwiki/vimwiki',
      enabled = true,
      lazy = true,
      keys = {
        { "<leader>ww", "<cmd>VimwikiIndex<cr>", desc = "open wiki index;" },
        { "<leader>wd", "<cmd>VimwikiIndex<cr>", desc = "open diary index;" },
        { "<leader>wl", "<cmd>VimwikiGenerateLinks<cr>", desc = "make links to each file;" },
        { "<leader>wc", "<cmd>VimwikiTOC<cr>", desc = "make table of contents in this file;" },
        { "<leader>wg", "<cmd>VimwikiGoto<cr>", desc = "find and open file;" },
      },
      init = function()
        vim.cmd([[
        set nocompatible
        filetype plugin on
        syntax on
        ]])
        vim.g.vimwiki_list = {
          {
            --path = "~/vimwiki/",
            --syntax = "wiki",
            --ext = ".wiki",
            on_attach = function(vClient, vBufferIndex)
            end,
          },
        }
      end,
    },
    --]==]
    -- [==[ localization
    {
      'nativerv/cyrillic.nvim',
      event = 'VeryLazy',
      config = function()
        require('cyrillic').setup({
          no_cyrillic_abbrev = true,
        })
      end
    },
    --]==]
  },
  -- colorscheme that will be used when installing plugins;
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates;
  checker = { enabled = true },
})
if not vLazyPcallSuccess then
  vim.api.nvim_echo({
    { "Failed to setup lazy.nvim:\n", "ErrorMsg" },
    { vLazyPcallMessage, "WarningMsg" },
    { "\nPress any key to exit..." },
  }, true, {})
end

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

--]=]

-- [=[ keymap

-- [==[ normal mode

vim.keymap.set("n", "u", "<cmd>undo<cr>", {
  ["remap"] = false,
  ["desc"] = "revert the last action;",
})
vim.keymap.set("n", "U", "<cmd>redo<cr>", {
  ["remap"] = false,
  ["desc"] = "revert the last undo;",
})

vim.keymap.set("n", "<c-w><c-e>", "<cmd>Explore<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of explorer",
})
vim.keymap.set("n", "<c-w><c-t>", "<cmd>split term://$SHELL<cr>", {
  ["remap"] = false,
  ["desc"] = "open window of terminal",
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
  ["desc"] = "switch to the prev tab;",
})
vim.keymap.set("n", "<leader>tm", "<cmd>tabm +1<cr>", {
  ["remap"] = false,
  ["desc"] = "move the current tab forward;",
})
vim.keymap.set("n", "<leader>tM", "<cmd>tabm -1<cr>", {
  ["remap"] = false,
  ["desc"] = "move the current tab backward;",
})

vim.keymap.set("n", "<c-w><c-q>", "<cmd>Bdelete!<cr>", {
  ["remap"] = false,
  ["desc"] = "delete the current buffer;",
})
vim.keymap.set("n", "gb", "<cmd>bn<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the next buffer;",
})
vim.keymap.set("n", "gB", "<cmd>bp<cr>", {
  ["remap"] = false,
  ["desc"] = "switch to the prev buffer;",
})
vim.keymap.set("n", "<leader>bm", "<cmd>BufferLineMoveNext<cr>", {
  ["remap"] = false,
  ["desc"] = "move buffer next;",
})
vim.keymap.set("n", "<leader>bM", "<cmd>BufferLineMovePrev<cr>", {
  ["remap"] = false,
  ["desc"] = "move buffer prev;",
})

vim.keymap.set("n", "!", ":! ", {
  ["remap"] = false,
  ["desc"] = "system command line;",
})

--]==]

-- [==[ terminal mode

vim.keymap.set("t","<c-]>","<c-\\><c-n>",{
  ["desc"]="switch from terminal to normal mode;"
})

--]==]

--]=]

--]]
