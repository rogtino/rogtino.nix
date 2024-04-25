vim.loader.enable()
local plugins_path = vim.fn.stdpath("data") .. "/lazy"
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

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
require("lazy").setup({
	{ import = "plugins" },
	{
		dir = "~/dev/neovim/heyoo/",
		lazy = false,
		-- config = function(_, opts)
		-- 	print("config")
		-- 	require("heyoo").setup(opts)
		-- end,
		-- opts = function(_, opts)
		-- 	opts.final_string = "daddy"
		-- 	print("opts")
		-- end,
	},
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

--TODO: vimtex autopairs octo textobject(treesitter) chatgpt nabla edgy neotest
--TODO: conceal some text
--TODO: there are some useful textobjs like L(url textobjs)...
--draw some insparation from astronvim
