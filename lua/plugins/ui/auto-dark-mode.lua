local change_theme = function(theme)
	local nvconfig = require("nvconfig")
	if string.match(theme, "light$") then
		vim.g.icon_toggled = false
		vim.g.toggle_theme_icon = "   "
	else
		vim.g.icon_toggled = true
		vim.g.toggle_theme_icon = "   "
	end
	nvconfig.ui.theme = theme
	require("base46").load_all_highlights()
end

return {
	{
		"f-person/auto-dark-mode.nvim",
		enabled = false,
		config = {
			update_interval = 500,
			set_dark_mode = function()
				change_theme("everforest")
			end,
			set_light_mode = function()
				change_theme("everforest_light")
			end,
		},
	},
}
