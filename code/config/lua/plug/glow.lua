--lua/plug/glow.lua - markdown preview

local glow = require("glow")

glow.setup({
    glow_path = "/usr/bin/glow",
    install_path = "~/.local/bin",
    border = "shadow",
    style = "dark",
    pager = false,
    width = 80,
    height = 100,
    width_ratio = 0.75,
    height_ratio = 0.75,
}) --glow

--endf
