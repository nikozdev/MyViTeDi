-- [[ neovim config by nikozdev

function FReLoad()
    vim.notify('Reload is being done!', vim.log.levels.INFO)
    -- Clear cached modules
    for name, _ in pairs(package.loaded) do
        package.loaded[name] = nil
    end
    -- Source your init.lua file
    dofile(vim.env.MYVIMRC)
    vim.notify('Reload has been done!', vim.log.levels.INFO)
end

local function fUpdLeader()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
end
fUpdLeader()

-- [=[ command line

vim.opt["shell"] = vim.env["SHELL"]

vim.opt["cmdheight"] = 4

vim.opt["history"] = 256

-- ]=]

-- [=[ visual

local function fUpdColors()
    vim.opt.termguicolors = (os.getenv('COLORTERM') == '24bit')
    vim.opt.background = 'dark'
end
fUpdColors()

vim.opt.conceallevel = 0

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

if vim.g.neovide == true then
    vim.g.neovide_fullscreen = true
end

-- ]=]

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

-- ]=]

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

-- ]==]

-- auto complete menu;
vim.opt["wildmenu"] = true
-- make auto complete menu behave like a zsh completion;
vim.opt["wildmode"] = "list:full"
-- do not auto complete these;
vim.opt["wildignore"] = { "*/cache/*", "*/tmp/*", "*/.git/*" }

vim.opt["showmatch"] = true
-- (0.1 * n) of a second to show the matching;
vim.opt["matchtime"] = 2

-- ]=]

-- [=[ completion

vim.opt["complete"] = { ".", "w", "b", "u", "t", }
vim.opt["completeopt"] = { "menu", "menuone", "noselect", }

-- ]=]

-- [=[ search/replace

--search highlighting
vim.opt["hlsearch"] = true
--update search during the typing
vim.opt["incsearch"] = true
--do not affect search by capital/regular case
vim.opt["ignorecase"] = true

-- ]=]

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

local vLazySpec = {
    -- [==[ package management
    {
        "vhyrro/luarocks.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = true,
    },
    -- ]==]
    -- [==[ navigation
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        enabled = true,
        lazy = true,
        event = "VeryLazy",
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
        build = './install --bin',
        dependencies = 'BurntSushi/ripgrep',
        enabled = true,
        lazy = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        enabled = true,
        lazy = true,
        event = "VeryLazy",
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
                    file_ignore_patterns = {
                        "Build/",
                        ".git",
                        ".cache",
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
                        additional_args = {
                            "--hidden",
                            "--no-ignore-vcs",
                        },
                    },
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
        end,
    },
    {
        'folke/which-key.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'echasnovski/mini.nvim',
        },
        enabled = true,
        lazy = true,
        event = "VeryLazy",
        keys = {
            {
                "<leader>/",
                function() require("which-key").show({ global = true }) end,
                desc = "WhichKey: global keymaps",
            },
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "WhichKey: local keymaps",
            },

            -- lazy

            { "<leader>vp", "<cmd>Lazy<cr>", desc = "Vim Plugins", },

            -- jumps

            { "<leader>ji", "<c-o>", { desc = "Jump Incoming" } },
            { "<leader>jo", "<c-i>", { desc = "Jump Outgoing" } },
            { "<leader>jl", "<cmd>jumps<cr>", { desc = "Jump List" } },

            -- splits

            { "<leader>s,", "<cmd>wincmd W<cr>", { desc = "Split prev" } },
            { "<leader>s.", "<cmd>wincmd w<cr>", { desc = "Split next" } },

            { "<leader>sh", "<cmd>wincmd h<cr>", { desc = "Split goto Left" } },
            { "<leader>sl", "<cmd>wincmd l<cr>", { desc = "Split goto Right" } },
            { "<leader>sj", "<cmd>wincmd j<cr>", { desc = "Split goto Down" } },
            { "<leader>sk", "<cmd>wincmd k<cr>", { desc = "Split goto Up" } },

            { "<leader>sH", "<cmd>wincmd H<cr>", { desc = "Split move Left" } },
            { "<leader>sL", "<cmd>wincmd L<cr>", { desc = "Split move Right" } },
            { "<leader>sJ", "<cmd>wincmd J<cr>", { desc = "Split move Down" } },
            { "<leader>sK", "<cmd>wincmd K<cr>", { desc = "Split move Up" } },
            { "<leader>sT", "<cmd>wincmd T<cr>", { desc = "Split move Tab" } },

            { "<leader>ss", "<cmd>sp<cr>", { desc = "Split creation" } },
            { "<leader>sv", "<cmd>vs<cr>", { desc = "Split Vertically" } },
            { "<leader>sd", "<cmd>close<cr>", { desc = "Split Deletion" } },

            -- tabs

            { "<leader>t,", "<cmd>tabp<cr>", { desc = "Tab goto Prev" } },
            { "<leader>t.", "<cmd>tabn<cr>", { desc = "Tab goto Next" } },

            { "<leader>t[", "<cmd>tabm -1<cr>", { desc = "Tab move Backward" } },
            { "<leader>t]", "<cmd>tabm +1<cr>", { desc = "Tab move Forward" } },

            { "<leader>tc", "<cmd>tabnew<cr><cmd>Bdelete<cr>", { desc = "Tab Creation" } },
            { "<leader>td", "<cmd>close<cr>", { desc = "Tab Deletion" } },

            -- misc

            { "<leader>vw", "<cmd>write<cr>", desc = "Vim: Write" },
            { "<leader>vs", "<cmd>e $MYVIMRC<cr>", desc = "Vim: Settings" },
            { '<leader>vl', '<cmd>lua FReLoad()<cr>', desc = "Vim: reLoad" },
            { "<leader>vc", "<cmd>close<cr>", desc = "Vim: Close" },
            { "<leader>vq", "<cmd>quitall<cr>", desc = "Vim: Quit" },

            { "u", "<cmd>undo<cr>", desc = "UnDo the last action" },
            { "г", "<cmd>undo<cr>", desc = "UnDo the last action" },
            { "<leader>vu", "<cmd>undo<cr>", desc = "Vim: Undo" },
            { "U", "<cmd>redo<cr>", desc = "ReDo the last action" },
            { "Г", "<cmd>redo<cr>", desc = "ReDo the last action" },
            { "<leader>vr", "<cmd>redo<cr>", desc = "Vim: Redo" },

            { "!", ":! ", desc = "System Command Line" },
            { 'zS', fSetCodeFolder, desc = 'Setup code folding settings' },
            { '<c-]>', mode = 't', '<c-\\><c-n>', desc = "Switch from Terminal to Normal mode" },
        },
    },
    {
        'chrisgrieser/nvim-spider',
        enabled = true,
        lazy = true,
        keys = function()
            local spider = require('spider')
            return {
                { 'w', function() spider.motion('w', { skipInsignificantPunctuation = false }) end, desc = "head of the next word" },
                { 'e', function() spider.motion('e', { skipInsignificantPunctuation = false }) end, desc = "tail of the curr/next word" },
                { 'b', function() spider.motion('b', { skipInsignificantPunctuation = false }) end, desc = "head of the prev/curr word" },
            }
        end
    },
    {
	    "tris203/precognition.nvim",
	    enabled = false,
	    lazy = true,
        keys = { { '<leader>kp', "<cmd>Precognition toggle<cr>", desc = 'Key Precognition' } },
	    opts = {
		    startVisible = false,
		    showBlankVirtLine = false,
		    highlightColor = { link = "Comment" },
		    hints = {
			    Caret = { text = "^", prio = 0 },
			    Dollar = { text = "$", prio = 0 },
			    MatchingPair = { text = "%", prio = 0 },
			    Zero = { text = "0", prio = 0 },
			    w = { text = "w", prio = 10 },
			    b = { text = "b", prio = 9 },
			    e = { text = "e", prio = 8 },
			    W = { text = "W", prio = 7 },
			    B = { text = "B", prio = 6 },
			    E = { text = "E", prio = 5 },
		    },
		    gutterHints = {
			    PrevParagraph = { text = "{", prio = 8 },
			    NextParagraph = { text = "}", prio = 8 },
		    },
		    disabled_fts = { "startify" },
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
    {
        "goolord/alpha-nvim",
        dependencies = 'nvim-tree/nvim-web-devicons',
        enabled = true,
        lazy = false,
        cmd = 'Alpha',
        keys = {
            { '<leader>vi', "<cmd>Alpha<cr>", desc = "Vim: Intro;" },
        },
        config = function()
            local vModule = require('alpha')
            local function fSetTheme(vThemeName)
                local vTheme = require('alpha.themes.' .. vThemeName)
                if vTheme.file_icons then
                    vTheme.file_icons.provider = "devicons"
                end
                vModule.setup(vTheme.config)
            end
            --fSetTheme('startify')
            --fSetTheme('dashboard')
            fSetTheme('theta')
        end,
    },
    {
        'Shatur/neovim-session-manager',
        dependencies = "nvim-lua/plenary.nvim",
        enabled = true,
        lazy = false,
        cmd = "SessionManager",
        keys = {
            { "<leader>pl", "<cmd>SessionManager load_last_session<cr>", desc = "Project: Last session" },
            { "<leader>pm", "<cmd>SessionManager load_session<cr>", desc = "Project: session Menu" },
            { "<leader>pf", "<cmd>SessionManager load_current_dir_session<cr>", desc = "Project: Folder session" },
            { "<leader>pg", "<cmd>SessionManager load_git_session<cr>", desc = "Project: Git session" },
            { "<leader>ps", "<cmd>SessionManager save_current_session<cr>", desc = "Project: Save session" },
            { "<leader>pd", "<cmd>SessionManager delete_session<cr>", desc = "Project: Delete session" },
        },
        config = function()
            local tPath = require('plenary.path')
            local vModule = require('session_manager')
            local vConfig = require('session_manager.config')
            vModule.setup({
                sessions_dir = tPath:new(vim.fn.stdpath('data'), 'sessions'),
                autoload_mode = { vConfig.AutoloadMode.LastSession, vConfig.AutoloadMode.CurrentDir },
                autosave_last_session = true,
                autosave_ignore_not_normal = true,
                autosave_ignore_dirs = {},
                autosave_ignore_filetypes = {
                    'gitcommit',
                    'gitrebase',
                },
                autosave_ignore_buftypes = {},
                autosave_only_in_session = false,
                max_path_length = 64,
            })
        end,
    },
    -- ]==]
    -- [==[ development
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
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
        enabled = true,
        lazy = false,
    },
    {
        'williamboman/mason.nvim',
        enabled = true,
        config = true,
        lazy = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        cmd = 'Mason',
        keys = {
            { '<leader>lm', '<cmd>Mason<cr>', desc = 'LanguageMason interface;' },
        },
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = {
                    --"bashls",
                    "marksman",
                    --"html",
                    "lua_ls",
                    "clangd",
                    --"pyright",
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
                --vLspCaps = vCmpNvimLsp.update_capabilities(vNvimCaps)
                vLspCaps = vCmpNvimLsp.default_capabilities(vNvimCaps)
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
                        vim.api.notify(vMessage)
                    end
                else
                    vim.api.notify("The LSP config \"" .. vName .. "\" was not found")
                end
            end
            -- [==[ running setup
            fRunLspSetup("bashls")

            fRunLspSetup("marksman")
            fRunLspSetup("html")
            fRunLspSetup("zk")

            fRunLspSetup("lua_ls", {
                filetypes = { 'lua' },
                root_dir = function()
                    return false
                end,
                single_file_support = true,
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
                on_attach = function()
                    if false then -- causing lags
                        vim.api.nvim_create_autocmd("BufWritePost", {
                            pattern = { "*.cpp", "*.hpp" },
                            command = "silent !clang-format --style=file -i %",
                        })
                    end
                end,
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
    -- ]==]
    -- [==[ editing
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
        },
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
    },
    -- ]==]
    -- [==[ interface
    {
        "MunifTanjim/nui.nvim",
        enabled = true,
        lazy = true,
    },
    {
        "rcarriga/nvim-notify",
        enabled = true,
        lazy = false,
        config = function()
            local notify = require('notify')
            notify.setup()
            vim.notify = notify
        end
    },
    {
        'nativerv/cyrillic.nvim',
        enabled = true,
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('cyrillic').setup({
                no_cyrillic_abbrev = true,
            })
        end
    },
    -- ]==]
    -- [==[ visual
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        enabled = true,
        lazy = true,
        event = { 'BufNew', 'TabNew' },
        init = function()
            fUpdColors()
        end,
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'buffers',
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
                    separator_style = 'slope',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        }
                    },
                    hover = { enabled = false },
                    max_name_length = 12,
                    max_prefix_length = 8,
                    truncate_names = true,
                    tab_size = 16,
                    diagnostics = "nvim_lsp",
                    persist_buffer_sort = true,
                    move_wraps_at_ends = false,
                    always_show_bufferline = true,
                    auto_toggle_bufferline = false,
                    sort_by = 'insert_after_current',
                },
                -- highlights = { tab_selected = { fg = "#ffffff", bg = "#aaaaaa", bold = true } },
                --[[
                highlights = require("nord").bufferline.highlights({
                    italic = true,
                    bold = true,
                }),
                -- ]]
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
        end,
    },
    {
        'vim-scripts/restore_view.vim',
        enabled = true,
        lazy = false,
    },
    -- ]==]
    -- [==[ colors
    {
        'levouh/tint.nvim',
        enabled = true,
        lazy = true,
        event = 'WinNew',
        config = function()
            local tint = require('tint')
            tint.setup({
                tint = -75,
                saturation = 0.25,
                transforms = tint.transforms.SATURATE_TINT,
                tint_background_colors = true,
                highlight_ignore_patterns = { "WinSeparator", "Status.*" },
                window_ignore_function = function(winid)
                    local bufid = vim.api.nvim_win_get_buf(winid)
                    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
                    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
                    -- Do not tint `terminal` or floating windows, tint everything else
                    --return buftype == "terminal" or floating
                    return false
                end
            })
        end,
    },
    { -- very colorful, dimming inactive windows (replaced by tint)
        'sontungexpt/witch',
        enabled = false,
        lazy = true,
        cmd = 'Witch',
        opts = {
            theme = {
                enabled = true,
                style = 'dark',
                extras = {
                    bracket = false,
                    dashboard = false,
                    diffview = false,
                    explorer = false,
                    indentline = false,
                },
            },
            dim_inactive = {
                enabled = true,
                level = 0.5,
                excluded = {
                    filetypes = { NvimTree = false },
                    buftypes = {
                        nofile = false,
                        prompt = false,
                        terminal = false,
                    },
                },
            }
        },
        config = true,
    },
    { -- weak comments
        'kvrohit/substrata.nvim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("substrata") end
    },
    { -- nice and shiny, darky comments
        'FrenzyExists/aquarium-vim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("aquarium") end
    },
    { -- bad contrast of comments
        'slugbyte/lackluster.nvim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("lackluster") end
    },
    { -- too dark for mee
        'kdheepak/monochrome.nvim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("monochrome") end
    },
    { -- too hight contrast, very colorful and bright
        'fenetikm/falcon',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("falcon") end,
    },
    { -- too high contrast
        'dasupradyumna/midnight.nvim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("midnight") end
    },
    { -- nice, blue, dark, bright, colorful
        'shaunsingh/nord.nvim',
        enabled = true,
        lazy = false,
        config = function() vim.cmd.colorscheme("nord") end
    },
    { -- nice, dark, grim, gothic, gray, colorless
        'zenbones-theme/zenbones.nvim',
        dependencies = "rktjmp/lush.nvim",
        enabled = true,
        lazy = false,
        init = function() vim.g.zenbones_compat = 1; end,
        config = function() vim.cmd.colorscheme('neobones'); fUpdColors(); end,
    },
    { -- one of the best
        'EdenEast/nightfox.nvim',
        enabled = false,
        lazy = false,
        config = function() vim.cmd.colorscheme("nightfox") end
    },
    { -- high contrast, dark, colorful
        'rockerBOO/boo-colorscheme-nvim',
        enabled = true,
        lazy = false,
        config = function()
            vim.cmd.colorscheme("boo")
            --vim.cmd.colorscheme("sunset_cloud")
            --vim.cmd.colorscheme("crimson_moonlight")
            --vim.cmd.colorscheme("radioactive_waste")
            --vim.cmd.colorscheme("forest_stream")
        end
    },
    { -- nice, blue, dark, mild
        'kyazdani42/blue-moon',
        enabled = false,
        lazy = false,
        config = function()
            fUpdColors();
            vim.cmd.colorscheme("blue-moon")
        end
    },
    -- ]==]
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
    -- ]==]
    -- [==[ source control
    {
        'lewis6991/gitsigns.nvim',
        enabled = true,
        lazy = true,
        keys = {
            { '<leader>gg', '<cmd>Gitsigns<cr>', desc = "Gitsigns Global" },
            { '<leader>go', '<cmd>Gitsigns show<cr>', desc = "Gitsigns Orig" },
            { '<leader>gd', '<cmd>Gitsigns diffthis<cr>', desc = "Gitsigns Diff" },
            -- hunks
            { '<leader>gh', '<cmd>Gitsigns setloclist<cr>', desc = "Gitsigns list Hunks" },
            { '<leader>g,', '<cmd>Gitsigns prev_hunk<cr>', desc = "Gitsigns Next Hunk" },
            { '<leader>g.', '<cmd>Gitsigns next_hunk<cr>', desc = "Gitsigns Prev Hunk" },
            { '<leader>gv', '<cmd>Gitsigns preview_hunk<cr>', desc = "Gitsigns View hunk" },
            { '<leader>gl', '<cmd>Gitsigns preview_hunk_inline<cr>', desc = "Gitsigns hunk Line" },
            { '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = "Gitsigns Stage/unStage hunk" },
            { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = "Gitsigns Reset Hunk" },
            -- blame
            { '<leader>gb', '<cmd>Gitsigns blame_line<cr>', desc = "Gitsigns Blame Hunk" },
            -- toggle
            { '<leader>gts', '<cmd>Gitsigns toggle_signs<cr>', desc = "Gitsigns Toggle Signs" },
            { '<leader>gtd', '<cmd>Gitsigns toggle_deleted<cr>', desc = "Gitsigns Toggle Deleted" },
            { '<leader>gtl', '<cmd>Gitsigns toggle_linehl<cr>', desc = "Gitsigns Toggle Line highlight" },
            { '<leader>gtn', '<cmd>Gitsigns toggle_numhl<cr>', desc = "Gitsigns Toggle line Numbers" },
            { '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<cr>', desc = "Gitsigns Toggle Words" },
        },
        config = true,
        opts = {
            signs_staged_enable = true,
            signcolumn = true,
            numhl = true,
            linehl = false,
            word_diff = false,
            max_file_length = 16000,
        },
    },
    -- ]==]
    -- [==[ networking
    {
        "oysandvik94/curl.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        enabled = true,
        lazy = true,
        cmd = "CurlOpen",
        config = true,
        opts = {
            default_flags = { '--compressed', '-k' },
            open_with = "split",
        },
    },
    -- ]==]
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
        cmd = { 'VimwikiIndex', 'VimwikiDiaryIndex', 'VimwikiMakeDiaryNote' },
        keys = function()
            --[===[
            vim.g.vimwiki_key_mappings = {
                -- all_maps = 0,
                global = 0,
            }
            --]===]
            return {
                { "<leader>ww", "<cmd>VimwikiIndex<cr>", desc = "VimwikiIndex" },
                { "<leader>w<leader>i", "<cmd>VimwikiDiaryIndex<cr>", desc = "VimwikiDiaryIndex" },
                { "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<cr>", desc = "VimwikiMakeDiaryNote" },
                --[===[
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
                -- ]===]
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
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'hrsh7th/nvim-cmp',
            'nvim-treesitter/nvim-treesitter',
        },
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
    -- ]==]
    -- [==[ play
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        enabled = true,
        lazy = vim.fn.argv()[1] ~= 'leetcode.nvim',
        cmd = 'Leet',
        keys = {
            { '<leader>cm', "<cmd>Leet<cr>", "Competition: Menu" },
            { '<leader>cl', "<cmd>Leet list<cr>", "Competition: Listing of questions" },
            { '<leader>cr', "<cmd>Leet run<cr>", "Competition: Running of the solution" },
            { '<leader>cs', "<cmd>Leet submit<cr>", "Competition: Submission of the solution" },
            { '<leader>cc', "<cmd>Leet console<cr>", "Competition: Console of the question" },
            { '<leader>cd', "<cmd>Leet desc<cr>", "Competition: Description of the question" },
            { '<leader>ci', "<cmd>Leet info<cr>", "Competition: Information of the question" },
        },
        opts = {
            arg = 'leetcode.nvim',
            lang = 'cpp',
            plugins = {
                non_standalone = true,
            },
            injector = {
                ['cpp'] = {
                    before = {
                        "#include <bits/stdc++.h>",
                        "using namespace std;",
                    },
                    after = {
                        "int main()",
                        "{",
                        "return 0;",
                        "}",
                    },
                },
            },
            description = {
                position = "left",
                width = "40%",
                show_stats = true,
            },
            storage = {
                home = vim.fn.stdpath("data") .. "/leetcode",
                cache = vim.fn.stdpath("cache") .. "/leetcode",
            },
            logging = true,
        },
    },
    -- ]==]
}
vLazyPcallSuccess, vLazyPcallMessage = pcall(require("lazy").setup, {
    spec = vLazySpec,
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

-- ]=]

-- ]]
