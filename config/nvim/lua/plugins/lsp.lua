local function config()
	-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- capabilities.offsetEncoding = { "utf-16" }
	local servers = {
		astro = {},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					completion = { callSnippet = "Replace" },
					hint = { enable = true },
					workspace = {
						library = {
							-- require("neodev.config").types(),
							vim.env.VIMRUNTIME,
						},
						checkThirdParty = false,
					},
				},
			},
		},
		-- ruff_lsp = {},
		pyright = {},
		-- html = {},
		taplo = {},
		prismals = {},
		emmet_language_server = {},
		gopls = {},
		cssls = {},
		asm_lsp = {},
		marksman = {},
		-- BUG:no idea why this triggers an error in :LspInfo
		-- mdx_analyzer = {
		-- 	filetypes = "mdx",
		-- },
		clangd = {
			on_attach = function()
				require("clangd_extensions.inlay_hints").setup_autocmd()
				require("clangd_extensions.inlay_hints").set_inlay_hints()
			end,
		},
		tailwindcss = {},
		bashls = {},
		nil_ls = {},
		cmake = {},
		solidity_ls = {},
		phpactor = {},
		qmlls = {},
		typst_lsp = { settings = { exportPdf = "onSave" } },
	}
	for client, setup in pairs(servers) do
		setup = vim.tbl_deep_extend("force", {
			-- capabilities = capabilities,
			on_attach = function(cli)
				if cli.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable()
				end
			end,
		}, setup)
		require("lspconfig")[client].setup(setup)
	end
end
return {
	{
		"neovim/nvim-lspconfig",
		config = config,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"folke/neodev.nvim",
				config = true,
			},
			{
				"mfussenegger/nvim-lint",
				config = function()
					require("lint")["linters_by_ft"] = {
						markdown = { "vale" },
						cpp = { "clangtidy" },
						python = { "ruff" },
						-- lua = { "luacheck" },
						-- typescriptreact = { "eslint_d" },
						-- javascript = { "eslint_d" },
						-- typescript = { "eslint_d" },
						-- javascriptreact = { "eslint_d" },
					}
				end,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^4",
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client)
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable()
						end
					end,
				},
			}
		end,
		keys = {
			{
				"<localleader>r",
				function()
					vim.cmd.RustLsp("runnables")
				end,
				ft = "rust",
				desc = "runnables",
			},
			{
				"<localleader>e",
				function()
					vim.cmd.RustLsp("expandMacro")
				end,
				ft = "rust",
				desc = "expand-macro",
			},
		},
	},
	{
		"folke/trouble.nvim",
		branch = "dev", -- IMPORTANT!
		cmd = "Trouble",
		keys = {
			{
				"<leader>sd",
				"<cmd>Trouble diagnostics preview focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>sb",
				"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>ls",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			-- TODO: use float win when it stables
			{
				"<leader>lf",
				"<cmd>Trouble lsp toggle focus=true win.position=left<cr>",
				desc = "LSP finder (Trouble)",
			},
			-- {
			-- 	"<leader>lp",
			-- 	"<cmd>Trouble lsp toggle_preview focus=true win.position=left<cr>",
			-- 	desc = "LSP Definitions / references / ... (Trouble)",
			-- },
			-- {
			-- 	"<leader>xL",
			-- 	"<cmd>Trouble loclist toggle<cr>",
			-- 	desc = "Location List (Trouble)",
			-- },
			-- {
			-- 	"<leader>xQ",
			-- 	"<cmd>Trouble qflist toggle<cr>",
			-- 	desc = "Quickfix List (Trouble)",
			-- },
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},
	"p00f/clangd_extensions.nvim",
	-- BUG: polute input
	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = true,
	-- },
}
