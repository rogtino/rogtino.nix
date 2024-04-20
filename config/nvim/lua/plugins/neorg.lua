return {
	-- BUG: unable to use in nixos
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"nvim-neorg/neorg",
		cmd = "Neorg",
		keys = {
			{ "<leader>nn", ":Neorg workspace learn<CR>", desc = "open workspace" },
			{ "<leader>nj", ":Neorg journal ", desc = "journal" },
			{ "<leader>nt", ":Neorg journal today<CR>", desc = "today's journal" },
			{ "<localleader>tg", ":Neorg tangle current-file<CR>", ft = "norg" },
		},
		ft = "norg",
		-- version = "v7.0.0",
		version = "*",
		-- build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.dirman"] = { config = { workspaces = { learn = "~/some-notes" } } },
				["core.summary"] = {},
				["core.ui.calendar"] = {},
				["core.concealer"] = { config = { icon_preset = "diamond" } },
				["core.keybinds"] = {
					config = {
						hook = function(keybinds)
							keybinds.remap_event("norg", "n", ",e", "core.looking-glass.magnify-code-block")
							-- keybinds.map("norg", "n", "q", vim.cmd.q)
							keybinds.map("norg", "n", ",s", "<cmd>Neorg generate-workspace-summary<CR>")
							-- keybinds.map_to_mode("ui", {
							-- 	n = {
							-- 		{
							-- 			"q",
							-- 			vim.cmd.q,
							-- 			opts = { desc = "[neorg] quit" },
							-- 		},
							-- 	},
							-- }, {
							-- 	silent = true,
							-- 	noremap = true,
							-- })
						end,
					},
				},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.journal"] = { config = { workspace = "learn" } },
				["core.presenter"] = { config = { zen_mode = "zen-mode" } },
				["core.export.markdown"] = {},
				["core.export"] = {},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg-telescope",
			"luarocks.nvim",
		},
	},
}
