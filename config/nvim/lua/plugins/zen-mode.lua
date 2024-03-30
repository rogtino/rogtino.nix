return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 0.95,
			width = 120,
			height = 1,
			options = {
				signcolumn = "yes",
				number = true,
				relativenumber = true,
				foldcolumn = "0",
				cursorline = false,
			},
		},
		plugins = { gitsigns = { enabled = true } },
	},
	cmd = "ZenMode",
}
