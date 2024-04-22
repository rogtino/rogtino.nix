return {
	-- {
	-- 	"ziontee113/deliberate.nvim",
	-- 	dependencies = {
	-- 		{
	-- 			"anuvyklack/hydra.nvim",
	-- 		},
	-- 	},
	-- 	lazy = false,
	-- 	config = function()
	-- 		local supported_filetypes = { "typescriptreact" }
	-- 		local augroup = vim.api.nvim_create_augroup("DeliberateEntryPoint", { clear = true })
	-- 		vim.api.nvim_create_autocmd({ "FileType" }, {
	-- 			pattern = supported_filetypes,
	-- 			group = augroup,
	-- 			callback = function()
	-- 				local bufnr = vim.api.nvim_get_current_buf()
	-- 				if vim.tbl_contains(supported_filetypes, vim.bo.ft) then
	-- 					vim.keymap.set("n", "<leader>d", function()
	-- 						vim.api.nvim_input("<Plug>DeliberateHydraEsc")
	-- 					end, { buffer = bufnr, desc = "toggle deliberate" })
	-- 					vim.keymap.set("i", "<Plug>DeliberateHydraEsc", "<Nop>", {})
	-- 				end
	-- 			end,
	-- 		})
	--
	-- 		require("deliberate.hydra")
	-- 	end,
	-- },
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			---Render style
			---@usage 'background'|'foreground'|'virtual'
			render = "background",

			---Set virtual symbol (requires render to be set to 'virtual')
			virtual_symbol = "■",

			---Highlight named colors, e.g. 'green'
			enable_named_colors = true,

			---Highlight tailwind colors, e.g. 'bg-blue-500'
			enable_tailwind = true,

			---Set custom colors
			---Label must be properly escaped with '%' to adhere to `string.gmatch`
			--- :help string.gmatch
			-- custom_colors = {
			-- 	{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
			-- 	{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
			-- },
		},
		event = "VeryLazy",
	},
	{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = { color_square_width = 2 } },
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescriptreact", "javascriptreact", "javascript", "typescript" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- config = true,
		opts = {
			on_attach = function()
				vim.lsp.inlay_hint.enable()
			end,
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},

	{
		"ziontee113/icon-picker.nvim",
		opts = { disable_legacy_commands = true },
		keys = {
			{

				"<leader>si",
				function()
					vim.cmd.IconPickerInsert("nerd_font_v3")
				end,
				desc = "search a icon",
				mode = "n",
			},
		},
	},
	{
		"max397574/colortils.nvim",
		cmd = "Colortils",
		config = true,
		keys = {
			{
				"<leader>pc",
				function()
					vim.cmd.Colortils()
				end,
				desc = "Colortils",
			},
		},
	},
}
