local function config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
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
							require("neodev.config").types(),
							-- vim.env.VIMRUNTIME,
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
			capabilities = capabilities,
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
}
