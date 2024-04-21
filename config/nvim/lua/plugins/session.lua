return {
	"Shatur/neovim-session-manager",
	event = "VeryLazy",
	keys = {
		{
			"<leader>le",
			"<cmd>SessionManager load_session<CR>",
			{ desc = "load session" },
		},
		{
			"<leader>ld",
			"<cmd>SessionManager load_current_dir_session<CR>",
			{ desc = "load current session" },
		},
		{
			"<leader>la",
			"<cmd>SessionManager load_last_session<CR>",
			{ desc = "load last session" },
		},
	},
	config = function()
		local config = require("session_manager.config")
		require("session_manager").setup({ autoload_mode = config.AutoloadMode.Disabled })
	end,
}
