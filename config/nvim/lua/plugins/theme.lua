return {
	{ "folke/tokyonight.nvim", priority = 1000 },
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = true,
	},
	{
		"olimorris/onedarkpro.nvim",
		lazy = true,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{
		"folke/noice.nvim",

		opts = {
			lsp = {
				override = {
					["cmp.entry.get_documentation"] = true,
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				hover = {
					silent = true,
				},
			},
			routes = {
				{
					filter = {
						any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } },
						event = "msg_show",
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				inc_rename = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
}
