local function config()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			sorting_strategy = "ascending",
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },
			file_ignore_patterns = { ".git/", "node_modules" },
			layout_strategy = "center",
			border = false,
			layout_config = {
				anchor = "N",
				preview_cutoff = 1,
				prompt_position = "top",
				width = 0.95,
			},
		},
		-- pickers = {
		-- 	find_files = { theme = "ivy", find_command = { "rg", "--hidden", "--glob", "!.git", "--files" } },
		-- 	live_grep = { theme = "ivy", find_command = { "rg", "--hidden", "--glob", "!.git", "--files" } },
		-- },
		-- extensions = {
		-- 	codebase = {
		-- 		path = vim.fn.stdpath("config") .. "/codebase",
		-- 	},
		-- },
	})
	telescope.load_extension("ui-select")
	telescope.load_extension("luasnip")
	telescope.load_extension("env")
	telescope.load_extension("gitmoji")
	telescope.load_extension("ports")
	-- telescope.load_extension("codebase")
	-- telescope.load_extension("manix")
end
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"benfowler/telescope-luasnip.nvim",
		-- not compatiable with flake
		-- see:https://github.com/mlvzk/manix/issues/25
		-- {
		-- 	"MrcJkb/telescope-manix",
		-- 	keys = {
		-- 		{ "<leader>hn", "<ESC>:Telescope manix<CR>", desc = "help for nix functions" },
		-- 	},
		-- },
		{
			"mrjones2014/tldr.nvim",
			keys = { { "<leader>ht", ":Telescope tldr<CR>", desc = "tldr" } },
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"LinArcX/telescope-env.nvim",
		"olacin/telescope-gitmoji.nvim",
		"LinArcX/telescope-ports.nvim",
		"prochri/telescope-all-recent.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader><leader>",
			function()
				return vim.cmd.Telescope("find_files")
			end,
		},
		{
			"<leader>f",
			function()
				return vim.cmd.Telescope("live_grep")
			end,
			desc = "live grep",
		},
		{
			"<leader>pe",
			function()
				return vim.cmd.Telescope("env")
			end,
			desc = "pick-env",
		},
		{
			"<leader>pb",
			function()
				return vim.cmd.Telescope("buffers")
			end,
			desc = "pick-buffer",
		},
		{ "<leader>hh", ":Telescope help_tags<CR>", desc = "help" },
		{
			"<leader>pj",
			function()
				return vim.cmd.Telescope("gitmoji")
			end,
			desc = "pick-gitmoji",
		},
		{
			"<leader>pm",
			function()
				return vim.cmd.Telescope("man_pages")
			end,
			desc = "pick-man-page",
		},
	},
	config = config,
}
