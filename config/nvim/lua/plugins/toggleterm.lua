return {
	"akinsho/toggleterm.nvim",
	-- config = config,
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = "<c-t>",
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 3,
			highlights = {
				FloatBorder = { link = "FloatBorder" },
				NormalFloat = { link = "NormalFloat" },
			},
		},
		winbar = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>th",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
				return htop:toggle()
			end,
			desc = "htop",
		},
		{
			"<leader>ty",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local yazi = Terminal:new({ cmd = "yazi", hidden = true, direction = "float" })
				return yazi:toggle()
			end,
			desc = "yazi",
		},
		{
			"<leader>tg",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
				return lazygit:toggle()
			end,
			desc = "lazygit",
		},
		{
			"<leader>t1",
			function()
				vim.cmd("1ToggleTerm")
			end,
			desc = "open first term",
		},
		{
			"<leader>t2",
			function()
				vim.cmd("2ToggleTerm")
			end,
			desc = "open second term",
		},
		{
			"<leader>t3",
			function()
				vim.cmd("3ToggleTerm")
			end,
			desc = "open third term",
		},
		"<c-t>",
	},
	cmd = "ToggleTerm",
}
