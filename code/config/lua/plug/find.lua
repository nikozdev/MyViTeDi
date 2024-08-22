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
}) --tele

--endf
