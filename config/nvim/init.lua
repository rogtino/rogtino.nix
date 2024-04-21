vim.loader.enable()
local plugins_path = vim.fn.stdpath("data") .. "/lazy"

local function boot(name, url)
	local package_path = plugins_path .. "/" .. name
	if not vim.uv.fs_stat(package_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--single-branch",
			url,
			package_path,
		})
	end
	vim.opt.runtimepath:prepend(package_path)
end

boot("lazy.nvim", "https://github.com/folke/lazy.nvim.git")
-- TODO:https://github.com/CKolkey/ts-node-action add some node-action
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.disable_autoformat = false
require("lazy").setup({
	{ import = "plugins" },
	-- {
	-- 	dir = "~/dev/neovim/heyoo/",
	-- 	lazy = false,
	-- 	-- config = function(_, opts)
	-- 	-- 	print("config")
	-- 	-- 	require("heyoo").setup(opts)
	-- 	-- end,
	-- 	-- opts = function(_, opts)
	-- 	-- 	opts.final_string = "daddy"
	-- 	-- 	print("opts")
	-- 	-- end,
	-- },
	-- {
	-- 	dir = "~/neovim/heyoo/",
	-- 	opts = function(_, opts)
	-- 		opts.final_string = "son"
	-- 	end,
	-- },
}, {
	defaults = { lazy = true },
	performance = {
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			disabled_plugins = {
				--NOTE: can't make zip work,disable all of them ATM
				"gzip",
				"matchit",
				-- "matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- checker = { enabled = true },
	-- dev = {
	--   path = "~/dev-nvim/",
	--   patterns = { "rogtino" },
	-- },
})
require("core")
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

-- NOTE:detecting node type to disable parenthesis completion
vim.keymap.set({ "n", "i" }, "<F12>", function()
	-- local ts_utils = require("nvim-treesitter.ts_utils")
	-- local s = ts_utils.get_node_at_cursor():type()
	-- local a = ts_utils.get_previous_node(s):type()
	-- vim.print(a)
	-- local r = vim.inspect(s)
	-- vim.print(s)
	-- vim.print(vim.treesitter.get_captures_at_cursor())
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.treesitter.get_node({
		bufnr = bufnr,
		ignore_injections = false,
	})
	if cursor == nil then
		print("cursor is nil")
	else
		local parent = cursor:parent()
		if parent ~= nil then
			print(parent:type())
		else
			print("parent is nil")
		end
	end
end)
--TODO: vimtex autopairs octo textobject(treesitter) chatgpt nabla edgy neotest
--TODO: conceal some text
--TODO: there are some useful textobjs like L(url textobjs)...
--draw some insparation from astronvim
