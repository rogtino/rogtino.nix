--TODO: lazy load plugins which can be lazy load
-- make all config in opts table
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

-- NOTE:this bug bothers me for a long time,if I mapleader after lazy.setup ,the keys map in spec won't work
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy").setup("plugins", {
	-- defaults = { lazy = true },
	-- checker = { enabled = true },
	-- dev = {
	--   path = "~/dev-nvim/",
	--   patterns = { "rogtino" },
	-- },
})
require("core")
vim.cmd.colorscheme("rose-pine")
-- vim.cmd.colorscheme "tokyonight-moon"

-- NOTE:detecting node type to disable parenthesis completion
vim.keymap.set({ "n", "i" }, "<F12>", function()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local s = ts_utils.get_node_at_cursor():type()
	vim.print(s)
end)
--TODO: vimtex autopairs octo textobject(treesitter) chatgpt nabla edgy neotest
--TODO: conceal some text
--TODO: there are some useful textobjs like L(url textobjs)...
--draw some insparation from astronvim
