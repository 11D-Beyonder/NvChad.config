local M = {}

M.ui = {
	theme_toggle = { "gruvbox", "gruvbox_light" },
	theme = "gruvbox",
	lsp = {
		signature = true,
	},
	nvdash = {
		load_on_startup = true,
		buttons = {},
	},
	term = {
		float = {
			row = 0.1,
			col = 0.1,
			width = 0.8,
			height = 0.6,
		},
	},
	tabufline = {
		lazyload = false,
	},
}

return M
