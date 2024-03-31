local userlspocnfig = vim.api.nvim_create_augroup("UserLspConfig", {})
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*",
	group = userlspocnfig,
	callback = function()
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "go to declaration" })
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "go to definition" })
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "go to implementation" })
		-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "hover doc" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover doc" })
		vim.keymap.set("n", "<c-leftmouse>", "<cmd>Lspsaga goto_definition<CR>")
		vim.keymap.set("n", "<c-rightmouse>", "<c-o>")
		vim.keymap.set("n", "<rightmouse>", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "previous diagnostic" })
		vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "next diagnostic" })
		-- vim.keymap.set("n", "<leader>sd", vim.diagnostic.setloclist, { desc = "search diagnostic loclist" })
		vim.keymap.set("n", "<leader>sd", vim.cmd.TroubleToggle, { desc = "search diagnostic in trouble" })
		vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "lsp finder" })
		vim.keymap.set("n", "<leader>lp", "<cmd>Lspsaga peek_definition<CR>", { desc = "peek definition" })
		vim.keymap.set("n", "<leader>lc", "<cmd>Lspsaga code_action<CR>", { desc = "code action" })
		vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "rename symbol" })
		vim.keymap.set("n", "<leader>ls", "<cmd>Lspsaga outline<CR>", { desc = "outline symbols" })
		vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", { desc = "incoming calls" })
		vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "outgoing calls" })
		vim.keymap.set("n", "<leader>lm", "<cmd>LspInfo<CR>", { desc = "lspinfo" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "WildMenu", timeout = 400 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "readme.norg",
	callback = function()
		vim.cmd("Neorg export to-file readme.md")
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.mpp", "*.ixx" },
	callback = function()
		vim.opt.filetype = "cpp"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "cargo.lock", "flake.lock" },
	callback = function()
		vim.opt.filetype = "json"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"startuptime",
		"qf",
		"lspinfo",
		"man",
		"query",
		"checkhealth",
		"toggleterm",
	},
	callback = function()
		vim.keymap.set("n", "q", vim.cmd.close)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "" then
			vim.keymap.set("n", "q", vim.cmd.bdelete, { buffer = true })
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "oil", "markdown" },
	callback = function()
		vim.keymap.set("n", "q", vim.cmd.Bdelete, { buffer = true })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

local change_on_disk = vim.api.nvim_create_augroup("ChangeOnDisk", {})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = change_on_disk,
	callback = function()
		if vim.fn.mode ~= "c" then
			vim.cmd.checktime()
		end
	end,
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = change_on_disk,
	callback = function()
		vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
	end,
})
