--lua/lspc/init.lua - language server protocol config

local lspc = require("lspconfig")
local lspcc = require("lspconfig.configs")
local lspcu = require("lspconfig.util")

local mason = require("mason")
local mason_lspc = require("mason-lspconfig")

local evar_home = os.getenv("HOME")
local evar_conf = evar_home .. "/.config"
local evar_nvim = evar_conf .. "/nvim"

local rtpath = vim.split(package.path, ";")
table.insert(rtpath, "lua/?.lua")
table.insert(rtpath, "lua/?/init.lua")

local capabilities = nil
pcall(function()
  local comp = require('cmp_nvim_lsp')
  local nvim_caps = vim.lsp.protocol.make_client_capabilities()
  --capabilities = comp.update_capabilities(nvim_caps)
  capabilities = comp.default_capabilities(nvim_caps)
end)

local lsp_lua_bin = vim.fn.exepath("lua-language-server")
local lsp_lua_dir = vim.fn.fnamemodify(lsp_lua_bin, ":h:h:h")

--use this function
--to only map the following keys
--when the language server is attached
local on_attach = function(client, bufnum)
  -- see `:help vim.lsp.*`
  local bufopt = {noremap=true,silent=true,buffer=bufnum}

  vim.keymap.set('n','gd', vim.lsp.buf.definition, bufopt)
  vim.keymap.set('n','gD', vim.lsp.buf.declaration, bufopt)
  vim.keymap.set('n','gi', vim.lsp.buf.implementation, bufopt)

  vim.keymap.set('n','<c-l><c-n>', vim.lsp.buf.rename, bufopt)
  vim.keymap.set('n','<c-l><c-r>', vim.lsp.buf.references, bufopt)
  vim.keymap.set('n','<c-l><c-h>', vim.lsp.buf.hover, bufopt)
  vim.keymap.set('n','<c-l><c-s>', vim.lsp.buf.signature_help, bufopt)
  vim.keymap.set('n','<c-l><c-d>', vim.diagnostic.open_float, bufopt)
  --[[
  vim.keymap.set('n','<c-l><c-f>', vim.lsp.buf.formatting, bufopt)
  --]]
end

mason.setup({})
mason_lspc.setup({
  automatic_installation = false,
  ensure_installed = {
    "marksman",
    "clangd",
  },
})

local function lspc_setup(name, args)
  args = args or {}
  args.on_attach = args.on_attach or on_attach
  args.capabilities = capabilities

  local success, message = pcall(lspc[name].setup, args)
  if not success then
    print(message)
  end
end

--mason

lspc_setup("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh", },
})

lspc_setup("marksman", {})
lspc_setup("html", {})

lspc_setup("clangd", {
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

lspc_setup("pyright", {})

--[=[
lspc_setup("sumneko_lua", {
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
--]=]

--custom

if not lspcc.luau then
  lspcc.luau = {
    default_config = {
      cmd = {
        "luau-lsp",
        "lsp",
        "--definitions=" .. evar_nvim .. "/lua/lspc/robloxdef.lua"
      },
      filetypes = { "lua", },
      --root_dir = lspcu.root_pattern("default.project.json"),
      root_dir = lspcu.root_pattern("sourcemap.json"),
      settings = {
      },
    },
  }
end
lspc_setup("luau", {

  on_attach = function(client, bufnum)

    on_attach(client, bufnum)

    local clients = vim.lsp.buf_get_clients()
    if #clients == 2 then
      for index, bufclient in pairs(clients) do
        if bufclient ~= client then
          bufclient.stop()
        end
      end
    end

  end

})

lspc_setup("rust_analyzer", {
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

lspc_setup("gopls", { })

lspc_setup("ols", { })

lspc_setup("julials", { })

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

lspc_setup("tsserver", { })

--endf
