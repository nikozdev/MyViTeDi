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

vim.opt.showtabline = 4

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

vim.opt.clipboard = "unnamedplus"

--do not make backup files
vim.opt["backup"] = false
--do not add the end of the line for explicity
vim.opt["fixendofline"] = false

--do not make backup files
vim.opt["clipboard"] = "unnamedplus"

--do not turn spaces into tabs
vim.opt["expandtab"] = true
--tabbing moves 4 spaces
vim.opt["tabstop"] = 4
--how many spaces to use in auto indent
vim.opt["shiftwidth"] = 4

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
            keys = {
                { '<leader>lm', '<cmd>Mason<cr>', desc = 'LanguageMason interface;' },
            },
        },
        {
            'williamboman/mason-lspconfig.nvim',
            enabled = true,
            lazy = true,
            event = 'VeryLazy',
            cmd = 'Mason',
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
                        fUpdLeader()

                        vim.keymap.set('n', '<leader>lgf', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = "GoTo Source|Header;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lgd', vim.lsp.buf.definition, { desc = "GoTo Definition|Declaration;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lgi', vim.lsp.buf.implementation, { desc = "GoTo Implementation;", buffer = vBufferIndex })

                        vim.keymap.set('n', '<leader>lsr', vim.lsp.buf.references, { desc = "Show References", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lss', vim.lsp.buf.workspace_symbol, { desc = "Show WorkSpace Symbols;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lsh', vim.lsp.buf.hover, { desc = "Show Hovering Information;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lsd', vim.diagnostic.open_float, { desc = "Show Diagnostics;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lsi', vim.lsp.buf.incoming_calls, { desc = "Show InComing Calls;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lso', vim.lsp.buf.outgoing_calls, { desc = "Show OutGoing Calls;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lsw', vim.lsp.buf.list_workspace_folders, { desc = "Show Workspace Folders;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lst', vim.lsp.buf.typehierarchy, { desc = "Show Type Hierarchy;", buffer = vBufferIndex })

                        vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, { desc = "Run Renaming;", buffer = vBufferIndex })
                        vim.keymap.set('n', '<leader>lrf', vim.lsp.buf.format, { desc = "Run Formatter;", buffer = vBufferIndex })
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

                fRunLspSetup("bashls")

                fRunLspSetup("marksman")
                fRunLspSetup("html")

                fRunLspSetup("clangd")

                fRunLspSetup("pyright")

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
                })

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

                fRunLspSetup("gopls")

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

                fRunLspSetup("ts_ls")

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
            cmd = 'DapNew',
            config = function()
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
            end,
        },
        {
            "neoclide/coc.nvim",
            branch = "release",
            enabled = false,
            lazy = true,
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
                    build = { './install --bin' },
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
                    'junegunn/fzf.vim',
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
                            find_command = { 'rg', '--files', '--hidden', '--follow', '-g', '!.git/', '-g', '!.cache/' },
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
            'folke/which-key.nvim',
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
                -- wins
                { "gw", "<cmd>tabn<cr>", { desc = "Go Win Forward;" } },
                { "gW", "<cmd>tabp<cr>", { desc = "Go Win Backward;" } },
                { "<leader>wgf", "<cmd>wincmd r<cr>", { desc = "Win Go Forward;" } },
                { "<leader>wgb", "<cmd>wincmd R<cr>", { desc = "Win Go Backward;" } },
                { "<leader>wgh", "<cmd>wincmd h<cr>", { desc = "Win Goto Left;" } },
                { "<leader>wgj", "<cmd>wincmd j<cr>", { desc = "Win Goto Down;" } },
                { "<leader>wgk", "<cmd>wincmd k<cr>", { desc = "Win Goto Up;" } },
                { "<leader>wgl", "<cmd>wincmd l<cr>", { desc = "Win Goto Right;" } },

                { "<leader>wmh", "<cmd>wincmd H<cr>", { desc = "Win Move Left;" } },
                { "<leader>wmj", "<cmd>wincmd J<cr>", { desc = "Win Move Down;" } },
                { "<leader>wmk", "<cmd>wincmd K<cr>", { desc = "Win Move Up;" } },
                { "<leader>wml", "<cmd>wincmd L<cr>", { desc = "Win Move Right;" } },
                { "<leader>wmt", "<cmd>wincmd T<cr>", { desc = "Win Move to the newTab;" } },

                { "<leader>wct", "<cmd>tabnew<cr>", { desc = "Win Open Tab;" } },
                { "<leader>wch", "<cmd>split<cr>", { desc = "Win Open Hsplit;" } },
                { "<leader>wcv", "<cmd>vsplit<cr>", { desc = "Win Open Vsplit;" } },
                { "<leader>wcs", "<cmd>edit term://$SHELL<cr>", { desc = "Win Open Shell;" } },
                { "<leader>wce", "<cmd>Explore<cr>", { desc = "Win Open Explorer;" } },
                { "<leader>wd", "<cmd>close<cr>", { desc = "Win Deletion;" } },
                -- tabs
                { "gt", "<cmd>tabn<cr>", { desc = "Go Tab Forward;" } },
                { "gT", "<cmd>tabp<cr>", { desc = "Go Tab Backward;" } },
                { "<leader>tgf", "<cmd>tabn<cr>", { desc = "Tab Go Forward;" } },
                { "<leader>tgb", "<cmd>tabp<cr>", { desc = "Tab Go Backward;" } },

                { "<leader>tmf", "<cmd>tabm +1<cr>", { desc = "Tab Move forward;" } },
                { "<leader>tmb", "<cmd>tabm -1<cr>", { desc = "Tab Move backward;" } },

                { "T", "<cmd>tabnew<cr>", { desc = "New Tab;" } },
                { "<leader>tc", "<cmd>tabnew<cr>", { desc = "Tab Creation;" } },
                { "<leader>td", "<cmd>close<cr>", { desc = "Tab Deletion;" } },
                -- misc
                { "u", "<cmd>undo<cr>", desc = "UnDo the last action;" },
                { "U", "<cmd>redo<cr>", desc = "ReDo the last action;" },
                { "Г", "<cmd>redo<cr>", desc = "ReDo the last action;" },
                { '<c-]>', mode = 't', '<c-\\><c-n>', desc = "Switch from the Terminal to the Normal mode;" },
                { "!", ":! ", desc = "System Command Line;" },
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
                'hrsh7th/cmp-vsnip',
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
                        },
                        component_separators = {
                            left = "",
                            right = "",
                        },
                        always_divide_middle = true,
                        globalstatus = false,
                    },
                    sections = {
                        lualine_a = { { "filename", path = 2 }, },
                        lualine_b = {
                            { "mode", fmt = function(str) return "m"..str:sub(1,1) end },
                            { "winnr", fmt = function(str) return "w"..str end },
                        }
                    },
                })
            end
        },
        {
            'vim-scripts/restore_view.vim',
            enabled = true,
            lazy = false,
        },
        {
            'winston0410/range-highlight.nvim',
            enabled = true,
            lazy = true,
            event = 'VeryLazy',
            config = true,
            dependencies = {
                'winston0410/cmd-parser.nvim',
            },
        },
        --]==]
        -- [==[ navigation
        {
            'akinsho/bufferline.nvim',
            version = "*",
            enabled = true,
            lazy = true,
            event = "BufEnter",
            dependencies = 'nvim-tree/nvim-web-devicons',
            init = function()
                vim.opt.termguicolors = true
            end,
            config = function()
                require('bufferline').setup({
                    options = {
                        numbers = "both",
                        close_command = "Bdelete! %d",
                        right_mouse_command = "Bdelete! %d",
                        color_icons = true,
                        show_buffer_icons = true,
                        show_buffer_close_icons = false,
                        show_close_icon = false,
                        show_tab_indicators = true,
                        show_duplicate_prefix = true,
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
                        max_name_length = 12,
                        max_prefix_length = 8,
                        truncate_names = true,
                        tab_size = 16,
                        diagnostics = "nvim_lsp",
                        persist_buffer_sort = true,
                        move_wraps_at_ends = true,
                        always_show_bufferline = true,
                        auto_toggle_bufferline = false,
                        sort_by = 'insert_after_current',
                    },
                    highlights = {
                        -- buffer_selected = { fg = "#ffffff", bg = "#282c34", bold = true },
                        tab_selected = { fg = "#ffffff", bg = "#aaaaaa", bold = true },
                    },
                })
            end,
            keys = {
                -- pick
                { '<leader>bpd', '<cmd>BufferLinePickClose<cr>', desc = "Buffer Pick Deletion;" },
                { "<leader>bgp", "<cmd>BufferLinePick<cr>", desc = "Buffer Goto Picked;" },
                -- move
                { "<leader>bmb", "<cmd>BufferLineMovePrev<cr>", desc = "Buffer Move Backward;" },
                { "<leader>bmf", "<cmd>BufferLineMoveNext<cr>", desc = "Buffer Move Forward;" },
                -- goto
                { "<leader>bgb", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer Go Backward;" },
                { "<leader>bgf", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer Go Forward;" },
                { "gb", "<cmd>BufferLineCycleNext<cr>", desc = "Go Buffer Forward;" },
                { "gB", "<cmd>BufferLineCyclePrev<cr>", desc = "Go Buffer Backward;" },
            },
        },
        {
            'famiu/bufdelete.nvim',
            enabled = true,
            lazy = true,
            keys = {
                { 'gd', '<cmd>Bdelete<cr>', desc = "Buffer Deletion;" },
                { '<leader>bd', '<cmd>Bdelete<cr>', desc = "Buffer Deletion;" },
            },
        },
        --]==]
        -- [==[ specific formats
        {
            'ellisonleao/glow.nvim',
            enabled = false,
            lazy = true,
            event = "BufReadPre *.md",
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
            cmd = { 'HexDump' },
            ft = { 'xxd' },
            config = function()
                require('hex').setup({})
            end,
            --[===[
            cond = function()
                -- full path of the current file
                local vFpath = vim.fn.expand('%:p')
                -- MIME type
                local vFtype = vim.fn.system("file --mime-type -b " .. vFpath)
                -- check if it's a binary file
                return vFtype:match("application/octet-stream") ~= nil
            end,
            --]===]
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
                --"kyazdani42/nvim-web-devicons",
                "nvim-tree/nvim-web-devicons",
            },
            rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim" },
            config = function()
                require("neorg").setup({
                    load = {
                        ['core.defaults'] = {},
                        ['core.dirman'] = {
                            config = { workspaces = { Basic = '~/Other/neorg' } },
                        },
                    },
                })
            end,
        },
        {
            'nvim-orgmode/orgmode',
            enabled = false,
            lazy = true,
            event = 'VeryLazy',
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
                { "<leader>kw", "<cmd>VimwikiIndex<cr>", desc = "KnowledgeBase Wiki index;" },
                { "<leader>kv", "<cmd>VimwikiCheckLinks<cr>", desc = "KnowledgeBase Vet links;" },
                { "<leader>kl", "<cmd>VimwikiGenerateLinks<cr>", desc = "KnowledgeBase Link generation;" },
                { "<leader>kc", "<cmd>VimwikiTOC<cr>", desc = "KnowledgeBase contents table in this file;" },
                { "<leader>kg", "<cmd>VimwikiGoto<cr>", desc = "KnowledgeBase Goto a file;" },
                { "<leader>kr", "<cmd>VimwikiRenameLink<cr>", desc = "KnowledgeBase Rename the current file link;" },
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
        {
            "jghauser/papis.nvim",
            enabled = false,
            lazy = true,
            event = 'VeryLazy',
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "hrsh7th/nvim-cmp",
                "kkharji/sqlite.lua",
                "MunifTanjim/nui.nvim",
                "pysan3/pathlib.nvim",
                "nvim-neotest/nvim-nio",
            },
            config = function()
                require("papis").setup({
                    -- Your configuration goes here
                })
            end,
        },
        {
            "epwalsh/obsidian.nvim",
            version = "*",
            enabled = false,
            lazy = true,
            keys = {
                { '<leader>do', '<cmd>ObsidianOpen<cr>', desc = "DatabaseOpen page;" },
                { '<leader>df', '<cmd>ObsidianQuickSwitch<cr>', desc = "DatabaseFind page;" },
                { '<leader>dd', '<cmd>ObsidianToday<cr>', desc = "DatabaseDiary page for today;" },
                { '<leader>dl', '<cmd>ObsidianLink<cr>', desc = "DatabaseLink the selected text to a page;" },
                { '<leader>dn', '<cmd>ObsidianNewFromTemplate<cr>', desc = "DatabaseNew page;" },
                { '<leader>dt', '<cmd>ObsidianTemplate<cr>', desc = "DatabaseTemplate;" },
                { '<leader>di', '<cmd>ObsidianPasteImg<cr>', desc = "DatabasePasteImage;" },
                { '<leader>dr', '<cmd>ObsidianRename<cr>', desc = "DatabaseRename;" },
            },
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope.nvim',
                'hrsh7th/nvim-cmp',
                'nvim-treesitter/nvim-treesitter',
            },
            opts = {
                workspaces = {
                    {
                        name = "LivaNota",
                        path = "~/Documents/LivaNota",
                        overrides = {
                            notes_subdir = 'Nota',
                        },
                    },
                },
                notes_subdir = 'Nota',
                new_notes_location = "Nota",
                daily_notes = {
                    folder = "Liva",
                    date_format = "%Y-%m-%d",
                    default_tags = { "Liva" },
                    template = 'Liva'
                },
                templates = {
                    folder = "Temp",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    substitutions = {},
                },
                ui = {
                    enable = false,
                    update_debounce = 1024,
                    max_file_length = 1024,
                },
                preferred_link_style = 'markdown',
            },
        },
        {
            'IlyasYOY/obs.nvim',
            enabled = false,
            lazy = false,
            dependencies = {
                "IlyasYOY/coredor.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
            },
            keys = {
                { '<leader>dn', '<cmd>ObsNvimFollowLink<cr>', desc = 'ObsNvimFollowLink' },
                { '<leader>dr', '<cmd>ObsNvimRandomNote<cr>', desc = 'ObsNvimRandomNote' },
                { '<leader>dN', '<cmd>ObsNvimNewNote<cr>', desc = 'ObsNvimNewNote' },
                { '<leader>dy', '<cmd>ObsNvimCopyObsidianLinkToNote<cr>', desc = 'ObsNvimCopyObsidianLinkToNote' },
                { '<leader>do', '<cmd>ObsNvimOpenInObsidian<cr>', desc = 'ObsNvimOpenInObsidian' },
                { '<leader>dd', '<cmd>ObsNvimDailyNote<cr>', desc = 'ObsNvimDailyNote' },
                { '<leader>dw', '<cmd>ObsNvimWeeklyNote<cr>', desc = 'ObsNvimWeeklyNote' },
                { '<leader>dr', '<cmd>ObsNvimRename<cr>', desc = 'ObsNvimRename' },
                { '<leader>dT', '<cmd>ObsNvimTemplate<cr>', desc = 'ObsNvimTemplate' },
                { '<leader>dM', '<cmd>ObsNvimMove<cr>', desc = 'ObsNvimMove' },
                { '<leader>db', '<cmd>ObsNvimBacklinks<cr>', desc = 'ObsNvimBacklinks' },
                { '<leader>df', '<cmd>ObsNvimFindNote<cr>', desc = 'ObsFind file;' },
                { '<leader>dg', '<cmd>ObsNvimFindInNotes<cr>', desc = 'ObsGrep text;' },
            },
            config = function()
                require('obs').setup({
                    vault_home = "~/Documents/LivaNota",
                    vault_name = "LivaNota",
                    journal = { template_name = "Liva" },
                })
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
        -- [==[ web and networking
        {
            "oysandvik94/curl.nvim",
            keys = {
                { "<leader>nco", "<cmd>CurlOpen<cr>", desc = "NetCurlOpen local scope;" },
                { "<leader>ncg", "<cmd>CurlOpen global<cr>", desc = "NetCurlOpen local scope;" },
                { "<leader>ncc", "<cmd>CurlClose<cr>", desc = "NetCurlClose current scope;" },
            },
            dependencies = "nvim-lua/plenary.nvim",
            config = true,
        },
        {
            'coffebar/transfer.nvim',
            enabled = false,
            lazy = true,
            keys = {
                {
                    "<leader>nti",
                    "<cmd>TransferInit<cr>",
                    desc = "NetworkTransfer Init/Edit Deployment config",
                    -- icon = { color = "green", icon = "" },
                },
                {
                    "<leader>ntd",
                    "<cmd>TransferDownload<cr>",
                    desc = "NetworkTransferDownload from the remote server (scp);",
                    -- icon = { color = "green", icon = "󰇚" },
                },
                {
                    "<leader>ntu",
                    "<cmd>TransferUpload<cr>",
                    desc = "NetworkTransferUpload onto the remote server (scp)",
                    -- icon = { color = "green", icon = "󰕒" },
                },
                {
                    "<leader>ntr",
                    "<cmd>TransferRepeat<cr>",
                    desc = "NetworkTransfer command Repeat;",
                    -- icon = { color = "green", icon = "󰑖" },
                },
                {
                    "<leader>ntf",
                    "<cmd>DiffRemote<cr>",
                    desc = "NetoworkTransferDIFF a file with the remote server (scp);",
                    -- icon = { color = "green", icon = "" },
                },
            },
            config = function()
                require('transfer').setup({})
            end
        },
        --]==]
        -- [==[ source control
        {
            "chrisgrieser/nvim-tinygit",
            enabled = false,
            lazy = true,
            event = 'VeryLazy',
            dependencies = {
                "stevearc/dressing.nvim",
                "nvim-telescope/telescope.nvim",
                "rcarriga/nvim-notify",
            },
            config = function()
                local tinygit = require('tinygit')
                tinygit.setup({})
            end,
        },
        {
            "f-person/git-blame.nvim",
            enabled = true,
            lazy = true,
            keys = {
                { '<leader>vg', '<cmd>GitBlameToggle<cr>', desc = 'git blame toggle ;' },
            },
            opts = {
                enabled = false,
                message_template = " <summary> • <date> • <author> • <<sha>>",
                date_format = "%m-%d-%Y %H:%M:%S",
                virtual_text_column = 1,
            },
            init = function()
                vim.g.gitblame_highlight_group = 'Question'
                vim.g.gitblame_date_format = '%r'
                vim.g.gitblame_display_virtual_text = 1
            end
        },
        --]==]
        -- [==[ misc
        {
            'eandrju/cellular-automaton.nvim',
            enabled = true,
            lazy = true,
            keys = {
                { '<leader>pgl', '<cmd>CellularAutomaton game_of_life<cr>', desc = 'PlayGameOfLife;' },
                { '<leader>pgr', '<cmd>CellularAutomaton make_it_rain<cr>', desc = 'PlayGameOfRain;' },
            },
        }
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

--]=]

--]]
