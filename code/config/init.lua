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

vim.opt.conceallevel = 2

vim.opt.showtabline = 4

vim.opt["title"] = true
vim.opt["splitright"] = true

vim.opt["mousehide"] = true

vim.opt["visualbell"] = true

vim.opt["lazyredraw"] = true

local function fSetCodeFolder()
    if vim.wo.foldmethod ~= 'diff' then
        vim.wo.foldmethod = 'syntax'
        vim.wo.foldminlines = 4
    end
end
--[==[
vim.api.nvim_create_augroup("CodeFolder", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = "CodeFolder",
  pattern = "*",
  callback = fSetCodeFolder,
})
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
        },
        {
            'williamboman/mason-lspconfig.nvim',
            enabled = true,
            lazy = true,
            event = 'VeryLazy',
            cmd = 'Mason',
            keys = {
                { '<leader>lm', '<cmd>Mason<cr>', desc = 'LanguageMason interface;' },
            },
            dependencies = {
                'williamboman/mason.nvim',
            },
            config = function()
                require("mason-lspconfig").setup({
                    automatic_installation = false,
                    ensure_installed = {
                        "bashls",
                        "marksman",
                        "html",
                        "lua_ls",
                        "clangd",
                        "pyright",
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

                        local function fKeyMap(vKey, vMap, vInf)
                            vOpt = {}
                            vOpt.desc = vInf
                            vim.keymap.set('n', vKey, vMap, vOpt)
                        end

                        fKeyMap('<leader>lj', '<cmd>ClangdSwitchSourceHeader<cr>', "Lsp Jump Between Source|Header;")
                        fKeyMap('<leader>lgf', '<cmd>ClangdSwitchSourceHeader<cr>', "Lsp GoTo Source|Header;")
                        fKeyMap('<leader>ld', vim.lsp.buf.definition, "Lsp Definition|Declaration;")
                        fKeyMap('<leader>lgd', vim.lsp.buf.definition, "Lsp GoTo Definition|Declaration;")
                        fKeyMap('<leader>lgi', vim.lsp.buf.implementation, "Lsp GoTo Implementation;")

                        fKeyMap('<leader>lr', vim.lsp.buf.references, "Lsp References")
                        fKeyMap('<leader>lsr', vim.lsp.buf.references, "Lsp Show References")
                        fKeyMap('<leader>lw', vim.lsp.buf.workspace_symbol, "Lsp WorkSpace Symbols;")
                        fKeyMap('<leader>lss', vim.lsp.buf.workspace_symbol, "Lsp Show WorkSpace Symbols;")
                        fKeyMap('<leader>lsh', vim.lsp.buf.hover, "Lsp Show Hovering Information;")
                        fKeyMap('<leader>lh', vim.lsp.buf.hover, "Lsp Help;")
                        fKeyMap('<leader>lsd', vim.diagnostic.open_float, "Lsp Show Diagnostics;")
                        fKeyMap('<leader>le', vim.diagnostic.open_float, "Lsp Errors;")

                        fKeyMap('<leader>lsi', vim.lsp.buf.incoming_calls, "Lsp Show InComing Calls;")
                        fKeyMap('<leader>li', vim.lsp.buf.incoming_calls, "Lsp InComing Calls;")
                        fKeyMap('<leader>lso', vim.lsp.buf.outgoing_calls, "Lsp Show OutGoing Calls;")
                        fKeyMap('<leader>lo', vim.lsp.buf.outgoing_calls, "Lsp OutGoing Calls;")
                        fKeyMap('<leader>lsw', vim.lsp.buf.list_workspace_folders, "Lsp Show Workspace Folders;")
                        fKeyMap('<leader>ll', vim.lsp.buf.list_workspace_folders, "Lsp List Workspace Folders;")
                        fKeyMap('<leader>lst', vim.lsp.buf.typehierarchy, "Lsp Show Type Hierarchy;")
                        fKeyMap('<leader>lt', vim.lsp.buf.typehierarchy, "Lsp Type Hierarchy;")

                        fKeyMap('<leader>ln', vim.lsp.buf.rename, "Lsp reName;")
                        fKeyMap('<leader>lf', vim.lsp.buf.format, "Lsp Format;")
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
                -- [==[ running setup
                fRunLspSetup("bashls")

                fRunLspSetup("marksman")
                fRunLspSetup("html")
                fRunLspSetup("zk")

                fRunLspSetup("lua_ls", {
                    root_dir = vim.loop.cwd,
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                            telemetry = { enable = false },

                        },
                    },
                })
                fRunLspSetup("clangd", {
                    timeout_ms = 4096,
                })
                fRunLspSetup("pyright")
                --]==]
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
                { 'junegunn/fzf', build = { './install --bin' } }
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
                },
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
                            find_command = {
                                'rg',
                                '--files',
                                '--hidden',
                                '--follow',
                                '-g',
                                '!.git/',
                                '-g',
                                '!.cache/',
                            },
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
                    { '<leader>ff', pTeleScopeBuiltIn.find_files, desc = "Fuzzy Find file;" },
                    { '<leader>fg', pTeleScopeBuiltIn.live_grep, desc = "Fuzzy Grep files;" },
                    { '<leader>fb', pTeleScopeBuiltIn.buffers, desc = "Fuzzy find Buf;" },
                    { '<leader>fc', pTeleScopeBuiltIn.commands, desc = "Fuzzy find Cmd;" },
                    { '<leader>fk', pTeleScopeBuiltIn.keymaps, desc = "Fuzzy find Key;" },
                }
            end
        },
        {
            'folke/which-key.nvim',
            lazy = true,
            event = "VeryLazy",
            keys = {
                {
                    "<leader>/",
                    function()
                        require("which-key").show({ global = true })
                    end,
                    desc = "WhichKey: global keymaps",
                },
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "WhichKey: local keymaps",
                },
                -- jumps
                { "<leader>j,", "<c-o>", { desc = "Jump prev" } },
                { "<leader>j.", "<c-i>", { desc = "Jump next" } },
                { "<leader>jl", "<cmd>jumps<cr>", { desc = "Jump List" } },
                -- wins
                { "<leader>w,", "<cmd>wincmd W<cr>", { desc = "Win prev" } },
                { "<leader>w.", "<cmd>wincmd w<cr>", { desc = "Win next" } },

                { "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Win goto Left" } },
                { "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Win goto Down" } },
                { "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Win goto Up" } },
                { "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Win goto Right" } },

                { "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Win Move Left" } },
                { "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Win Move Down" } },
                { "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Win Move Up" } },
                { "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Win Move Right" } },
                { "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Win move into Tab" } },

                { "<leader>wd", "<cmd>close<cr>", { desc = "Win Delete" } },
                { "<leader>ws", "<cmd>split<cr>", { desc = "Win horizontal Split" } },
                { "<leader>wv", "<cmd>vsplit<cr>", { desc = "Win Vertical split" } },
                -- tabs
                { "<leader>t,", "<cmd>tabp<cr>", { desc = "Tab Prev" } },
                { "<leader>t.", "<cmd>tabn<cr>", { desc = "Tab Next" } },

                { "<leader>t[", "<cmd>tabm -1<cr>", { desc = "Tab Backward" } },
                { "<leader>t]", "<cmd>tabm +1<cr>", { desc = "Tab Forward" } },

                { "<leader>tc", "<cmd>tabnew<cr><cmd>Bdelete<cr>", { desc = "Tab Creation" } },
                { "<leader>td", "<cmd>close<cr>", { desc = "Tab Deletion" } },
                -- misc
                { "<leader>vw", "<cmd>write<cr>", desc = "Vim: Write" },
                { "<leader>vc", "<cmd>close<cr>", desc = "Vim: Close" },
                { "<leader>vq", "<cmd>quitall<cr>", desc = "Vim: Quit" },
                { "u", "<cmd>undo<cr>", desc = "UnDo the last action" },
                { "г", "<cmd>undo<cr>", desc = "UnDo the last action" },
                { "<leader>vu", "<cmd>undo<cr>", desc = "Vim: Undo" },
                { "U", "<cmd>redo<cr>", desc = "ReDo the last action" },
                { "Г", "<cmd>redo<cr>", desc = "ReDo the last action" },
                { "<leader>vr", "<cmd>redo<cr>", desc = "Vim: Redo" },
                { "!", "<cmd>! ", desc = "System Command Line" },
                { 'zS', fSetCodeFolder, desc = 'Setup code folding settings' },
                { '<c-]>', mode = 't', '<c-\\><c-n>', desc = "Switch from Terminal to Normal mode" },
            },
            dependencies = {
                'nvim-tree/nvim-web-devicons',
                'echasnovski/mini.nvim',
            },
        },
        {
            'famiu/bufdelete.nvim',
            enabled = true,
            lazy = true,
            cmd = "Bdelete",
            keys = {
                { "<leader>bc", "<cmd>enew<cr>", desc = "Buf Creation;" },
                { '<leader>bd', '<cmd>Bdelete<cr>', desc = "Buf Deletion;" },
                { "<leader>be", "<cmd>Explore<cr>", { desc = "Buf Explorer" } },
                { "<leader>bt", "<cmd>edit term://$SHELL<cr>", { desc = "Buf Terminal" } },
            },
        },
        {
            'notomo/cmdbuf.nvim',
            enabled = false,
            lazy = true,
            keys = {
                { 'q/', function() require("cmdbuf").split_open(vim.o.cmdwinheight) end, desc = 'CommandLineMode Buffer' },
            },
        },
        --]==]
        -- [==[ completion
        {
            'hrsh7th/nvim-cmp',
            enabled = true,
            lazy = true,
            event = { 'InsertEnter', 'CmdlineEnter' },
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
                        ["<c-e>"] = pCmp.mapping.abort(),
                        ["<c-b>"] = pCmp.mapping.scroll_docs(0-4),
                        ["<c-f>"] = pCmp.mapping.scroll_docs(0+4),
                        ["<c-k>"] = pCmp.mapping.select_prev_item({}),
                        ["<c-j>"] = pCmp.mapping.select_next_item({}),
                        ["<s-tab>"] = pCmp.mapping.select_prev_item({}),
                        ["<tab>"] = pCmp.mapping.select_next_item({}),
                        -- ["<cr>"] = pCmp.mapping.confirm({ select = true }),
                    }),
                    sources = pCmp.config.sources({
                        { name = "buffer" },
                        { name = "nvim_lsp" },
                        { name = "vsnip" },
                        { name = "path" },
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
            'akinsho/bufferline.nvim',
            version = "*",
            enabled = true,
            lazy = true,
            event = { 'BufNew', 'TabNew' },
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
                { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Buf Goto Picked;" },
                -- move
                { "<leader>b[", "<cmd>BufferLineMovePrev<cr>", desc = "Buf Backward;" },
                { "<leader>b]", "<cmd>BufferLineMoveNext<cr>", desc = "Buf Forward;" },
                -- goto
                { "<leader>b,", "<cmd>BufferLineCyclePrev<cr>", desc = "Buf Prev;" },
                { "<leader>b.", "<cmd>BufferLineCycleNext<cr>", desc = "Buf Next;" },
            },
        },
        {
            'nvim-lualine/lualine.nvim',
            enabled = true,
            lazy = true,
            event = 'VeryLazy',
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
        --]==]
        -- [==[ specific formats
        {
            'RaafatTurki/hex.nvim',
            enabled = true,
            lazy = true,
            cmd = 'HexDump',
            ft = 'xxd',
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
            'nvim-orgmode/orgmode',
            enabled = false,
            lazy = true,
            event = 'VeryLazy',
            ft = 'org',
            keys = { '<leader>oa', '<leader>oc' },
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
            cmd = 'VimwikiIndex',
            keys = function()
                vim.g.vimwiki_key_mappings = {
                    all_maps = 0,
                    global = 0,
                }
                return {
                    { "<leader>kwi", "<cmd>VimwikiIndex<cr>", desc = "KnowledgeBase: Wiki Index" },
                    { "<leader>kwg", "<cmd>VimwikiGenerateLinks<cr>", desc = "KnowledgeBase: Wiki Generation" },
                    { "<leader>kdi", "<cmd>VimwikiDiaryIndex<cr>", desc = "KnowledgeBase: Diary Index" },
                    { "<leader>kdg", "<cmd>VimwikiDiaryGenerateLinks<cr>", desc = "KnowledgeBase: Diary Generation" },
                    { "<leader>kdd", "<cmd>VimwikiMakeDiaryNote<cr>", desc = "KnowledgeBase: Daily Diary" },

                    { "<leader>kct", "<cmd>VimwikiTOC<cr>", desc = "KnowledgeBase: Contents Table" },
                    { "<leader>kcr", "<cmd>VimwikiRss<cr>", desc = "KnowledgeBase: Contents Rss" },

                    { "<leader>kg", "<cmd>VimwikiSearch<cr>", desc = "KnowledgeBase: Grep" },
                    { "<leader>kf", "<cmd>VimwikiSearch<cr>", desc = "KnowledgeBase: Find" },

                    { "<leader>kv", "<cmd>VimwikiCheckLinks<cr>", desc = "KnowledgeBase: Verifify links" },
                    { "<leader>kr", "<cmd>VimwikiRenameLink<cr>", desc = "KnowledgeBase: Rename Link" },
                    { "<leader>kl", "<cmd>VimwikiPasteLink<cr>", desc = "KnowledgeBase: Paste Link" },
                    { "<leader>ku", "<cmd>VimwikiPasteUrl<cr>", desc = "KnowledgeBase: Paste URL" },

                    { "<leader>kfr", "<cmd>VimwikiDeleteFile<cr>", desc = "KnowledgeBase: File Renaming" },
                    { "<leader>kfd", "<cmd>VimwikiRenameFile<cr>", desc = "KnowledgeBase: File Deletion" },

                    { "<leader>khg", "<cmd>VimwikiAll2HTML<cr>", desc = "KnowledgeBase: Html Generation" },
                    { "<leader>khb", "<cmd>Vimwiki2HTML<cr>", desc = "KnowledgeBase: Html Browsing" },
                }
            end,
            init = function()
                vim.cmd([[
                set nocompatible
                filetype plugin on
                syntax on
                ]])
                vim.g.vimwiki_list = {
                    {
                        path = vim.fn.stdpath('data') .. "/vimwiki/",
                        --syntax = "wiki",
                        ext = ".wiki",
                        on_attach = function(vClient, vBufferIndex)
                        end,
                    },
                }
            end,
        },
        {
            "epwalsh/obsidian.nvim",
            version = "*",
            enabled = false,
            lazy = true,
            keys = {
                { '<leader>no', '<cmd>ObsidianOpen<cr>', desc = "livaNota Open page;" },
                { '<leader>nf', '<cmd>ObsidianQuickSwitch<cr>', desc = "livaNota Find page;" },
                { '<leader>nd', '<cmd>ObsidianToday<cr>', desc = "livaNota Diary page for today;" },
                { '<leader>nl', '<cmd>ObsidianLink<cr>', desc = "livaNota Link the selected text to a page;" },
                { '<leader>nn', '<cmd>ObsidianNewFromTemplate<cr>', desc = "livaNota New page;" },
                { '<leader>nt', '<cmd>ObsidianTemplate<cr>', desc = "livaNota Template;" },
                { '<leader>ni', '<cmd>ObsidianPasteImg<cr>', desc = "livaNota PasteImage;" },
                { '<leader>nr', '<cmd>ObsidianRename<cr>', desc = "livaNota Rename;" },
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
            'zk-org/zk-nvim',
            enabled = true,
            lazy = true,
            keys = function()
                local zkCommands = require("zk.commands")
                return {
                    {
                        '<leader>zz',
                        mode = 'n',
                        function()
                            print('Zettelkasten has been loaded')
                        end,
                        desc = "Zettelkasten: loader keybind"
                    },
                    {
                        '<leader>zi',
                        mode = 'n',
                        "<cmd>ZkIndex<cr>",
                        desc = "Zettelkasten: Index notes"
                    },
                    {
                        '<leader>zc',
                        mode = 'n',
                        "<cmd>ZkNew<cr>",
                        desc = "Zettelkasten: Create Note"
                    },
                    {
                        '<leader>zc',
                        mode = 'v',
                        "<cmd>'<,'>ZkNewFromTitleSelection<cr>",
                        desc = "Zettelkasten: Create note from visual selection"
                    },
                    {
                        '<leader>zl',
                        mode = 'v',
                        "<cmd>'<,'>ZkInsertLinkAtSelection<cr>",
                        desc = "Zettelkasten: Link visual selection"
                    },
                    {
                        '<leader>zn',
                        mode = 'n',
                        "<cmd>ZkNotes<cr>",
                        desc = "Zettelkasten: pick from Notes"
                    },
                    {
                        '<leader>zl',
                        mode = 'n',
                        "<cmd>ZkLinks<cr>",
                        desc = "Zettelkasten: pick from Links"
                    },
                    {
                        '<leader>zb',
                        mode = 'n',
                        "<cmd>ZkBacklinks<cr>",
                        desc = "Zettelkasten: pick from Backlinks"
                    },
                    {
                        '<leader>zv',
                        mode = 'v',
                        "<cmd>'<,'>ZkMatch<cr>",
                        desc = "Zettelkasten: pick from notes by Visual selection"
                    },
                    {
                        '<leader>zt',
                        mode = 'n',
                        function()
                            zkCommands.get('ZkTags')()
                        end,
                        desc = "Zettelkasten: pick from notes by Tags"
                    },
                    {
                        '<leader>zd',
                        mode = 'n',
                        function()
                            zkCommands.get('ZkDaily')()
                        end,
                        desc = "Zettelkasten: open Daily note"
                    },
                }
            end,
            config = function()
                local zk = require('zk')
                zk.setup({
                    picker = "telescope",
                    lsp = {
                        config = {
                            cmd = { "zk", "lsp" },
                            name = "zk",
                        },
                        -- automatically attach buffers in a zk notebook that match the given filetypes
                        auto_attach = {
                            enabled = true,
                            filetypes = { "markdown" },
                        },
                    },
                })
                local zkCommands = require("zk.commands")
                zkCommands.add('ZkDaily', function(opts)
                    opts = vim.tbl_extend("force", {}, opts or {})
                    zk.edit(opts, { title = 'daily' })
                end)
            end,
        },
        {
            'nvim-telekasten/telekasten.nvim',
            enabled = false,
            lazy = true,
            cmd = 'Telekasten',
            keys = {
                { '<leader>zz', "<cmd>Telekasten<cr>", desc = "Telekasten: menu" },
                { '<leader>zf', "<cmd>Telekasten find_notes<cr>", desc = "Telekasten: Find notes by title (filename)" },
                { '<leader>zr', "<cmd>Telekasten rename_note<cr>", desc = "Telekasten: Rename the current note" },
                { '<leader>zg', "<cmd>Telekasten search_notes<cr>", desc = "Telekasten: Grep notes by content" },
                { '<leader>zt', "<cmd>Telekasten tags<cr>", desc = "Telekasten: Tags" },
                { '<leader>zd', "<cmd>Telekasten goto_today<cr>", desc = "Telekasten: open Daily note for today" },
                { '<leader>zw', "<cmd>Telekasten goto_thisweek<cr>", desc = "Telekasten: open Weekly note for today" },
                { '<leader>zn', "<cmd>Telekasten new_templated_note<cr>", desc = "Telekasten: New note from template" },
                { '<leader>zl', "<cmd>Telekasten yank_notelink<cr>", desc = "Telekasten: yank Link" },
                { '<leader>zc', "<cmd>Telekasten show_calendar<cr>", desc = "Telekasten: Calendar" },
                { '<leader>zm', "<cmd>Telekasten insert_img_link<cr>", desc = "Telekasten: Media link insertion" },
                { '<leader>zp', "<cmd>Telekasten preview_img<cr>", desc = "Telekasten: media Preview" },
                { '<leader>zb', "<cmd>Telekasten insert_img_link<cr>", desc = "Telekasten: media Browsing" },
            },
            config = function()
                require('telekasten').setup({
                    home = vim.fn.expand("~/zk"),
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
            cmd = "CurlOpen",
            dependencies = "nvim-lua/plenary.nvim",
            config = true,
        },
        --]==]
        -- [==[ source control
        {
            'lewis6991/gitsigns.nvim',
            enabled = true,
            lazy = true,
            keys = {
                { '<leader>gg', '<cmd>Gitsigns<cr>', desc = "Gitsigns Global" },
                -- buffers
                { '<leader>gbo', '<cmd>Gitsigns show<cr>', desc = "Gitsigns Buffer Origin" },
                { '<leader>go', '<cmd>Gitsigns show<cr>', desc = "Gitsigns Orig" },
                { '<leader>gbd', '<cmd>Gitsigns diffthis<cr>', desc = "Gitsigns Buffer Differ" },
                { '<leader>gd', '<cmd>Gitsigns diffthis<cr>', desc = "Gitsigns Diff" },
                { '<leader>gbs', '<cmd>Gitsigns stage_buffer<cr>', desc = "Gitsigns Stage Buffer" },
                { '<leader>gbr', '<cmd>Gitsigns reset_buffer<cr>', desc = "Gitsigns Reset Buffer" },
                -- hunks
                { '<leader>ghg', '<cmd>Gitsigns setloclist<cr>', desc = "Gitsigns Get Hunks" },
                { '<leader>gl', '<cmd>Gitsigns setloclist<cr>', desc = "Gitsigns List Hunks" },
                { '<leader>ghf', '<cmd>Gitsigns next_hunk<cr>', desc = "Gitsigns Hunk Forward" },
                { '<leader>g]', '<cmd>Gitsigns next_hunk<cr>', desc = "Gitsigns Prev Hunk" },
                { '<leader>ghb', '<cmd>Gitsigns prev_hunk<cr>', desc = "Gitsigns Hunk Backward" },
                { '<leader>g[', '<cmd>Gitsigns prev_hunk<cr>', desc = "Gitsigns Next Hunk" },
                { '<leader>ghv', '<cmd>Gitsigns preview_hunk<cr>', desc = "Gitsigns preView Hunk" },
                { '<leader>gv', '<cmd>Gitsigns preview_hunk<cr>', desc = "Gitsigns preView Hunk" },
                { '<leader>ghl', '<cmd>Gitsigns preview_hunk_inline<cr>', desc = "Gitsigns Hunk Line" },
                { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', desc = "Gitsigns Stage Hunk" },
                { '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = "Gitsigns Stage Hunk" },
                { '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', desc = "Gitsigns Reset Hunk" },
                { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = "Gitsigns Reset Hunk" },
                { '<leader>ghu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = "Gitsigns Hunk Undo" },
                { '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = "Gitsigns Hunk Undo" },
                -- blame
                { '<leader>gbb', '<cmd>Gitsigns blame<cr>', desc = "Gitsigns Blame Buffer" },
                { '<leader>gbh', '<cmd>Gitsigns blame_line<cr>', desc = "Gitsigns Blame Hunk" },
                -- toggle
                { '<leader>gts', '<cmd>Gitsigns toggle_signs<cr>', desc = "Gitsigns Toggle Signs" },
                { '<leader>gtd', '<cmd>Gitsigns toggle_deleted<cr>', desc = "Gitsigns Toggle Deleted" },
                { '<leader>gtl', '<cmd>Gitsigns toggle_linehl<cr>', desc = "Gitsigns Toggle Line highlight" },
                { '<leader>gtn', '<cmd>Gitsigns toggle_numhl<cr>', desc = "Gitsigns Toggle line Numbers" },
            },
            config = true,
        },
        {
            'tanvirtin/vgit.nvim',
            enabled = false,
            lazy = true,
            keys = function()
                local vgit = require('vgit')
                return {
                    { '<leader>ghf', vgit.hunk_down, desc = "Git Hunk Forward;" },
                    { '<leader>ghb', vgit.hunk_up, desc = "Git Hunk Backward;" },
                    { '<leader>gha', vgit.hunk_stage, desc = "Git Hunk Add;" },
                    { '<leader>ghu', vgit.hunk_reset, desc = "Git Hunk Undo;" },
                    { '<leader>ghv', vgit.hunk_preview, desc = "Git Hunk View;" },
                    { '<leader>gb', vgit.buffer_blame_preview, desc = "Git Buffer Blame;" },
                    { '<leader>gd', vgit.buffer_diff_preview, desc = "Git Buffer Diffs;" },
                    { '<leader>gl', vgit.buffer_history_preview, desc = "Git Buffer History;" },
                    { '<leader>gu', vgit.buffer_reset, desc = "Git Buffer Undo;" },
                }
            end,
            dependencies = 'nvim-lua/plenary.nvim',
            config = function()
                require('vgit').setup()
            end,
        },
        {
            "f-person/git-blame.nvim",
            enabled = false,
            lazy = true,
            keys = {
                { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = 'Git Blame;' },
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
