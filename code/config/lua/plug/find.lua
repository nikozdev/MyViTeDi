--lua/plug/find.lua - finders and fuzzy plugins

local tele = require("telescope")

tele.setup({
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
}) --tele

require("treesitter-context").setup{
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
}

--endf
