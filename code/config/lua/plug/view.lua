--lua/plug/view.lua - visual plugins, colorschemes

local review = require('restore_view')
review.setup({})

require('gruvbox').setup({
  -- [[
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = "hard",
  palette_overrides = {
  },
  overrides = {
  },
  dim_inactive = true,
  transparent_mode = true,
  --]]
})
vim.cmd("colorscheme gruvbox")
