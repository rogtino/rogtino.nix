vim.g.all_colors = {
	dark = {
		"onedark",
		"rose-pine-main",
		"rose-pine-moon",
		"onedark_dark",
		"onedark_vivid",
		"gruvbox-baby",
		"oxocarbon",
		"tokyonight-storm",
		"tokyonight-night",
		"tokyonight-moon",
		"catppuccin-frappe",
		"catppuccin-macchiato",
		"catppuccin-mocha",
		"bamboo-vulgaris",
		"bamboo-multiplex",
		"nightfox",
		"duskfox",
		"terafox",
		"carbonfox",
	},
	light = {
		"onelight",
		"bamboo-light",
		"catppuccin-latte",
		"oxocarbon",
		"rose-pine-dawn",
		"tokyonight-day",
		"dayfox",
		"dawnfox",
	},
}
local theme = "catppuccin-mocha"
vim.g.current_theme = theme
vim.cmd.colorscheme(theme)