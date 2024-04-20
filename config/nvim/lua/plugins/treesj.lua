return {
	-- "nmac427/guess-indent.nvim",
	{
		"echasnovski/mini.align",
		config = true,
		keys = {
			{
				"ga",
				mode = "v",
				desc = "Align",
			},
			{
				"gA",
				mode = "v",
				desc = "Align with preview",
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = { {
			"<space>j",
			":TSJToggle<CR>",
			desc = "join or split",
		} },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { use_default_keymaps = false },
	},
}
