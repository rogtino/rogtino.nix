return {
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
	{
		"folke/neodev.nvim",
		opts = {
			library = { plugins = { "nvim-dap-ui" }, types = true },
		},
	},
	-- TODO: not stable for nightly
	-- {
	--   "nvim-zh/colorful-winsep.nvim",
	--   config = true,
	-- },
	-- {
	--   "LintaoAmons/bookmarks.nvim",
	--   dependencies = {
	--     { "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
	--   },
	--   keys = {
	--     { "ms", "<Cmd>BookmarksGoto<CR>", mode = { "n" }, desc = "select a bookmark" },
	--     { "ma", "<Cmd>BookmarksMark<CR>", mode = { "n" }, desc = "add a bookmark" },
	--   },
	--   lazy = false,
	-- },
	{
		"NoahTheDuke/vim-just",
		ft = { "just" },
	},
	"mfussenegger/nvim-jdtls",
	-- or tabout?
	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {
			-- configuration goes here
		},
	},
	--WARNING: wait for alacritty sixel support
	-- https://codeberg.org/dnkl/foot/issues/481 waiting for foot
	-- { "3rd/image.nvim", config = true, lazy = false, dependencies = { "luarocks.nvim" } },
	{
		"stevearc/oil.nvim",
		opts = {

			use_default_keymaps = true,
			keymaps = {
				["<TAB>"] = "actions.select",
				["<C-s>"] = false,
				["<C-v>"] = "actions.select_vsplit",
			},
			experimental_watch_for_changes = true,
			view_options = {
				show_hidden = true,
			},
		},
		lazy = false,
		keys = { { "<leader>o", vim.cmd.Oil, desc = "open oil" } },
	},
	{ "kaarmu/typst.vim", ft = "typst" },
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		opts = {
			dependencies_bin = {
				["typst-preview"] = "typst-preview",
				["websocat"] = nil,
			},
		},
	},
	{ "Weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
	{
		"Mythos-404/xmake.nvim",
		lazy = true,
		event = "BufReadPost xmake.lua",
		opts = {
			compile_command = {
				lsp = "clangd",
				dir = ".",
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
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
		"kylechui/nvim-surround",
		opts = {
			surrounds = {
				["F"] = {
					add = function()
						local config = require("nvim-surround.config")
						local result = config.get_input("Enter the generic type name: ")
						if result then
							return { { result .. "<" }, { ">" } }
						end
					end,
				},
			},
		},
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		opts = { check_ts = true, disable_filetype = { "apl", "TelescopePrompt" } },
		event = "InsertEnter",
	},
	{
		"mbbill/undotree",
		keys = { { "<leader>tu", vim.cmd.UndotreeToggle, desc = "toggle undo tree" } },
	},
	{
		"tpope/vim-eunuch",
		cmd = "Mkdir",
	},
	{
		"ellisonleao/carbon-now.nvim",
		opts = {
			options = {
				theme = "one-dark",
				bg = "pink",
				font_family = "Cascadia Code",
				titlebar = "made by pypro",
				drop_shadow = true,
			},
		},
		cmd = "CarbonNow",
	},
	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>sr",
				function()
					require("ssr").open()
				end,
				desc = "open-ssr",
			},
		},
		config = function()
			require("ssr").setup({
				min_width = 50,
				min_height = 5,
				keymaps = { close = "q", next_match = "n", prev_match = "N", replace_all = "<leader><cr>" },
			})
		end,
	},

	{
		"pwntester/octo.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
		config = true,
		cmd = "Octo",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, { desc = "stage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "reset hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage hunk" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "stage buffer" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "reset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "preview hunk" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "blame line" })
				map("n", "<leader>gd", gs.diffthis, { desc = "diff this" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "diff ~" })
				map("n", "<leader>gt", gs.toggle_deleted, { desc = "toggle deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	"onsails/lspkind.nvim",
	{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = { color_square_width = 2 } },
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescriptreact", "javascriptreact", "javascript", "typescript" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = true,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = { snippet_engine = "luasnip" },
		keys = {
			{
				"<leader>rf",
				":Neogen func<cr>",
				desc = "neogen function",
				mode = { "n" },
			},
			{
				"<leader>rt",
				":Neogen type<cr>",
				desc = "neogen type",
				mode = { "n" },
			},
			{
				"<leader>ri",
				":Neogen file<cr>",
				desc = "neogen file",
				mode = { "n" },
			},
			{
				"<leader>rc",
				":Neogen class<cr>",
				desc = "neogen class",
				mode = { "n" },
			},
		},
	},
	{
		"folke/flash.nvim",
		opts = { label = { uppercase = false } },
		keys = {
			{
				"s",
				function()
					require("flash").jump()
				end,
				desc = "Flash",
				mode = { "n", "x", "o" },
			},
			{
				"S",
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
				mode = { "n" },
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"r",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
				mode = "o",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		config = true,
		keys = {
			{ "<leader>go", vim.cmd.DiffviewOpen, desc = "open diffview" },
			{ "<leader>gc", vim.cmd.DiffviewClose, desc = "close diffview" },
		},
	},

	"rcarriga/nvim-notify",
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			prompt_func_return_type = {
				go = true,
				cpp = true,
				c = true,
				java = true,
				python = true,
				hpp = true,
				cxx = true,
			},
			prompt_func_param_type = {
				go = true,
				cpp = true,
				python = true,
				c = true,
				java = true,
				hpp = true,
				cxx = true,
			},
		},
		keys = {
			{
				"<leader>rr",
				"<ESC>:Telescope refactoring refactors<CR>",
				desc = "refactorings",
			},
		},
		config = true,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>bo", vim.cmd.BufferLineCloseOthers, desc = "delete other buffers" },
			{ "<leader>bp", vim.cmd.BufferLinePick, desc = "pick a buffer by buf's name" },
			{ "<leader>bd", vim.cmd.Bdelete, desc = "delete current buffer" },
			{
				"<leader>ba",
				function()
					vim.cmd("%bd")
				end,
				desc = "delete all buffers",
			},
			{ "<s-l>", vim.cmd.BufferLineCycleNext },
			{ "<s-h>", vim.cmd.BufferLineCyclePrev },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, _, _)
					local icon = ((level:match("error") and " ") or " ")
					return (" " .. icon .. count)
				end,
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
	{ "gennaro-tedesco/nvim-jqx", ft = { "json", "yaml" } },
	{
		"nvim-pack/nvim-spectre",
		config = true,
		keys = {
			{ "<leader>sp", vim.cmd.Spectre, desc = "open-spectre" },
			{
				"<leader>sc",
				function()
					return vim.cmd.Spectre({ "path", vim.fn.expand("%:t:p") })
				end,
				desc = "open-spectre-with-current-buffer",
			},
		},
	},
	{ "folke/twilight.nvim", config = true, cmd = { "Twilight" } },

	--not free :(
	--( pack :zbirenbaum/copilot.lua {:cmd :Copilot :event :InsertEnter :config true })
	{ "glepnir/lspsaga.nvim", branch = "main", opts = { lightbulb = { sign = false } }, event = "VeryLazy" },
	"folke/lsp-colors.nvim",
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = true,
	},
	{ "stevearc/dressing.nvim", config = true },
	-- { "elkowar/yuck.vim", ft = "yuck" },
	{ "echasnovski/mini.cursorword", config = true, event = "VeryLazy" },
	"p00f/clangd_extensions.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = true,
		keys = {
			{ "<leader>tn", "<cmd>Neotree toggle dir=./<CR>", desc = "neotree-root-toggle" },
			{ "<leader>tr", "<cmd>Neotree reveal toggle<CR>", desc = "neotree-reveal-toggle" },
			{ "<leader>tf", "<cmd>Neotree reveal toggle position=float<CR>", desc = "neotree-float-toggle" },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		event = "VeryLazy",
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
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
	{
		"famiu/bufdelete.nvim",
		cmd = "Bdelete",
	},
	-- "mong8se/actually.nvim",
	-- { "chrisgrieser/nvim-early-retirement", config = true, event = "VeryLazy" },
	{
		"stevearc/overseer.nvim",
		opts = {
			templates = { "builtin", "cpp", "run_script", "xmake" },
			actions = {
				["70vsplit"] = {
					desc = "open terminal in a vertical split",
					condition = function(task)
						local bufnr = task:get_bufnr()
						return bufnr and vim.api.nvim_buf_is_valid(bufnr)
					end,
					run = function(task)
						local util = require("overseer.util")
						vim.cmd([[70vsplit]])
						util.set_term_window_opts()
						vim.api.nvim_win_set_buf(0, task:get_bufnr())
						util.scroll_to_end(0)
					end,
				},
			},
		},
		keys = {
			{
				"<leader>ra",
				vim.cmd.OverseerQuickAction,
				mode = "n",
				desc = "run quickAction(overseer)",
			},
			{
				"<leader>rs",
				vim.cmd.OverseerRunScript,
				mode = "n",
				desc = "run script(overseer)",
			},
			{
				"<leader>rx",
				"<CMD>OverseerXmake<CR>",
				mode = "n",
				desc = " run xmake(overseer)",
			},
		},
	},
	-- no need :(
	-- {
	-- 	"folke/edgy.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		bottom = {
	-- 			{
	-- 				filter = function(_, win)
	-- 					return (vim.api.nvim_win_get_config(win).relative == "")
	-- 				end,
	-- 				ft = "toggleterm",
	-- 				size = { height = 0.4 },
	-- 			},
	-- 			{
	-- 				filter = function(buf)
	-- 					return not vim.b[buf].lazyterm_cmd
	-- 				end,
	-- 				ft = "lazyterm",
	-- 				size = { height = 0.4 },
	-- 				title = "LazyTerm",
	-- 			},
	-- 			"Trouble",
	-- 			{ ft = "qf", title = "QuickFix" },
	-- 			{
	-- 				filter = function(buf)
	-- 					return (vim.bo[buf].buftype == "help")
	-- 				end,
	-- 				ft = "help",
	-- 				size = { height = 20 },
	-- 			},
	-- 			{ ft = "spectre_panel", size = { height = 0.4 } },
	-- 		},
	-- 		left = {
	-- 			{
	-- 				filter = function(buf)
	-- 					return (vim.b[buf].neo_tree_source == "filesystem")
	-- 				end,
	-- 				ft = "neo-tree",
	-- 				size = { height = 0.5 },
	-- 				title = "Neo-Tree",
	-- 			},
	-- 			{
	-- 				filter = function(buf)
	-- 					return (vim.b[buf].neo_tree_source == "git_status")
	-- 				end,
	-- 				ft = "neo-tree",
	-- 				open = "Neotree position=right git_status",
	-- 				pinned = true,
	-- 				title = "Neo-Tree Git",
	-- 			},
	-- 			{
	-- 				filter = function(buf)
	-- 					return (vim.b[buf].neo_tree_source == "buffers")
	-- 				end,
	-- 				ft = "neo-tree",
	-- 				open = "Neotree position=top buffers",
	-- 				pinned = true,
	-- 				title = "Neo-Tree Buffers",
	-- 			},
	-- 			{ ft = "Outline", open = "Lspsaga outline", pinned = true },
	-- 			"neo-tree",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"rogtino/codebase.nvim",
	-- 	config = true,
	-- 	keys = { { "<leader>sc", ":Telescope codebase<CR>", desc = "search a piece of code" } },
	-- },
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				javascript = { "deno_fmt" },
				java = { "google-java-format" },
				json = { "deno_fmt" },
				c = { "clang_format" },
				css = { "prettier" },
				cpp = { "clang_format" },
				typescript = { "deno_fmt" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				typst = { "typstfmt" },
				javascriptreact = { "deno_fmt", "rustywind" },
				typescriptreact = { "deno_fmt", "rustywind" },
				python = { "black" },
				fennel = { "fnlfmt" },
				nix = { "alejandra" },
			},
			formatters = {
				fnlfmt = { command = "fnlfmt", args = { "$FILENAME" }, stdin = true },
			},
			-- format_after_save = { lsp_fallback = true },
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		event = "VeryLazy",
		keys = {
			{
				"<leader>st",
				vim.cmd.TodoTrouble,
				desc = "search all todo comments",
			},
		},
	},
	"folke/which-key.nvim",
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint")["linters_by_ft"] = {
				cpp = { "clangtidy" },
				-- typescriptreact = { "eslint_d" },
				-- javascript = { "eslint_d" },
				-- typescript = { "eslint_d" },
				-- javascriptreact = { "eslint_d" },
			}
		end,
	},
	{
		"JuanZoran/Trans.nvim",
		keys = {
			{
				"mm",
				"<Cmd>Translate<CR>",
				mode = { "n", "x" },
				desc = "󰊿 Translate",
			},
			{ "mk", "<Cmd>TransPlay<CR>", mode = { "n", "x" }, desc = " autoplay" },
			{ "mi", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
		},
		build = function()
			require("Trans").install()
		end,
		config = true,
		dependencies = "kkharji/sqlite.lua",
	},
	{
		"prochri/telescope-all-recent.nvim",
		config = true,
		dependencies = "kkharji/sqlite.lua",
		lazy = true,
	},
	{
		"kkharji/sqlite.lua",
		lazy = true,
		config = function()
			if string.find(vim.uv.os_uname().version, "NixOS") then
				local Job = require("plenary.job")
				local sqlite3_path = vim.fn.stdpath("config") .. "/sqlite3.path"
				Job:new({
					command = "cat",
					args = { sqlite3_path },
					on_exit = function(j, _)
						for _, value in ipairs(j:result()) do
							vim.g.sqlite_clib_path = value
						end
					end,
				}):sync()
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		config = true,
		event = "VeryLazy",
		enabled = string.find(vim.uv.os_uname().version, "NixOS") == nil,
	},
	-- {
	-- 	dir = "~/dev-nvim/tslt.nvim",
	-- },
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider-w",
			},
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider-e",
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider-b",
			},
		},
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
		-- BUG:mess commit buffer
		-- branch = "nightly",
		keys = {
			{
				"<leader>gn",
				"<cmd>Neogit<CR>",
				mode = "n",
				desc = "Neogit",
			},
		},
	},
	{
		"tzachar/highlight-undo.nvim",
		config = true,
	},
	-- { "max397574/better-escape.nvim", config = true },
	{
		"smoka7/multicursors.nvim",
		-- event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	{
		"mmarchini/bpftrace.vim",
		lazy = false,
	},
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
		"VidocqH/lsp-lens.nvim",
		config = true,
		event = "LspAttach",
	},
}
