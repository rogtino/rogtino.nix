local function config()
	local toggleterm = require("toggleterm")
	local Terminal = (require("toggleterm.terminal")).Terminal
	return toggleterm.setup({
		size = 20,
		open_mapping = "<c-\\>",
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = { border = "curved", winblend = 0, highlights = { border = "Normal", background = "Normal" } },
	})
end
local function toggle_htop()
	local Terminal = (require("toggleterm.terminal")).Terminal
	local htop = Terminal:new({ cmd = "htop", hidden = true })
	return htop:toggle()
end
local function toggle_yazi()
	local Terminal = (require("toggleterm.terminal")).Terminal
	local yazi = Terminal:new({ cmd = "yazi", hidden = true })
	return yazi:toggle()
end
local function toggle_lazygit()
	local Terminal = (require("toggleterm.terminal")).Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	return lazygit:toggle()
end
return {
	"akinsho/toggleterm.nvim",
	config = config,
	keys = {
		{ "<leader>th", toggle_htop, desc = "htop" },
		{ "<leader>ty", toggle_yazi, desc = "yazi" },
		{ "<leader>tg", toggle_lazygit, desc = "lazygit" },
		"<c-\\>",
	},
}
