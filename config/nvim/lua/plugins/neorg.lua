return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	-- BUG: not an editor command at the moment
	{
		"nvim-neorg/neorg",
		-- cmd = "Neorg",
		-- keys = {
		-- 	{ "<leader>n", ":Neorg workspace learn<CR>" },
		-- 	{ "<leader>j", ":Neorg journal " },
		-- 	{ "<localleader>tg", ":Neorg tangle current-file<CR>" },
		-- },
		ft = "norg",
		-- version = "*",
		-- build = ":Neorg sync-parsers",
		-- config = function()
		-- 	require("neorg").setup()
		-- end,
		-- opts = {
		-- 	load = {
		-- 		["core.defaults"] = {},
		-- 		["core.dirman"] = { config = { workspaces = { learn = "~/some-notes" } } },
		-- 		["core.summary"] = {},
		-- 		["core.ui.calendar"] = {},
		-- 		["core.concealer"] = {},
		-- 		["core.keybinds"] = {
		-- 			config = {
		-- 				hook = function(keybinds)
		-- 					keybinds.remap_event("norg", "n", ",e", "core.looking-glass.magnify-code-block")
		-- 				end,
		-- 			},
		-- 		},
		-- 		["core.completion"] = { config = { engine = "nvim-cmp" } },
		-- 		["core.journal"] = { config = { workspace = "learn" } },
		-- 		["core.qol.toc"] = {},
		-- 		["core.presenter"] = { config = { zen_mode = "zen-mode" } },
		-- 		["core.export.markdown"] = {},
		-- 		["core.integrations.telescope"] = {},
		-- 		["core.export"] = {},
		-- 	},
		-- },
		dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope", "luarocks.nvim" },
	},
}
