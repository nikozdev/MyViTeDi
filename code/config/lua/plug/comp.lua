--lua/plug/comp.lua - completion plugin

-- [=[
local cmp = require("cmp")

cmp.setup({

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

cmp.setup.cmdline("/", {

    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },

})
cmp.setup.cmdline(":", {

    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "path" },
        { name = "cmdline" },
    },

})
--]=]

--endf
