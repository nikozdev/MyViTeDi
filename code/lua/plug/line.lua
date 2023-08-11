--lua/plug/line.lua - status line plugin

local lual = require("lualine")

lual.setup({
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
}) --lualine

--endf
