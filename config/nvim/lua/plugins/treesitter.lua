local function config()
	-- vim.cmd("hi TreesitterContext guibg=#210102")
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"astro",
			"c",
			"lua",
			"vim",
			"fish",
			"prisma",
			"vimdoc",
			"query",
			"rust",
			"cpp",
			"fennel",
			"nix",
			"python",
			"bash",
			"typescript",
			"tsx",
			"proto",
			"html",
			"javascript",
			"java",
			"just",
			"json",
			"norg",
			"org",
			"cmake",
			"dart",
			"css",
			"diff",
			"dockerfile",
			"go",
			"gomod",
			"gitcommit",
			"git_rebase",
			"git_config",
			"php",
			"luadoc",
			"make",
			"markdown_inline",
			-- "nu",
			"sql",
			"kdl",
			"toml",
			"yaml",
			"meson",
			"zig",
			"regex",
			"gitignore",
			"markdown",
		},
		autotag = { enable = true },
		-- move = {
		-- 	enable = true,
		-- 	set_jumps = true, -- whether to set jumps in the jumplist
		-- 	goto_next_start = {
		-- 		["]m"] = "@function.outer",
		-- 		["]]"] = { query = "@class.outer", desc = "Next class start" },
		-- 		--
		-- 		-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
		-- 		["]o"] = "@loop.*",
		-- 		-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
		-- 		--
		-- 		-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
		-- 		-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
		-- 		["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
		-- 		["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
		-- 	},
		-- 	goto_next_end = {
		-- 		["]M"] = "@function.outer",
		-- 		["]["] = "@class.outer",
		-- 	},
		-- 	goto_previous_start = {
		-- 		["[m"] = "@function.outer",
		-- 		["[["] = "@class.outer",
		-- 	},
		-- 	goto_previous_end = {
		-- 		["[M"] = "@function.outer",
		-- 		["[]"] = "@class.outer",
		-- 	},
		-- 	-- Below will go to either the start or the end, whichever is closer.
		-- 	-- Use if you want more granular movements
		-- 	-- Make it even more gradual by adding multiple queries and regex.
		-- 	-- goto_next = {
		-- 	-- 	["]d"] = "@conditional.outer",
		-- 	-- },
		-- 	-- goto_previous = {
		-- 	-- 	["[d"] = "@conditional.outer",
		-- 	-- },
		-- },
		autopairs = { enable = true },
		highlight = { enable = true, disable = { "" }, additional_vim_regex_highlighting = { "org" } },
		indent = { enable = true },
		tree_setter = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
				scope_incremental = "<TAB>",
			},
		},
		auto_install = false,
		sync_install = false,
		textobjects = {
			-- lsp_interop = {
			-- 	enable = true,
			-- 	border = "none",
			-- 	floating_preview_opts = {},
			-- 	peek_definition_code = {
			-- 		["<leader>df"] = "@function.outer",
			-- 		["<leader>dF"] = "@class.outer",
			-- 	},
			-- },
			select = {
				enable = true,

				-- Automatically jump forward to textobjects, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				},
				-- You can choose the select mode (default is charwise 'v')
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`. Can also be a function (see above).
				include_surrounding_whitespace = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["]p"] = "@parameter.inner",
				},
				swap_previous = {
					["[p"] = "@parameter.inner",
				},
			},
		},
	})
end
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = config,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	-- { "m-demare/hlargs.nvim", config = true },
	-- { "echasnovski/mini.ai", config = true },
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	opts = {
	-- 		-- cursor = { enable = false },
	-- 		-- scroll = { enable = true },
	-- 	},
	-- },
	{ "windwp/nvim-ts-autotag", ft = { "typescriptreact", "javascriptreact", "html" } },
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true, disabledKeymaps = { "gc" } },
		event = "VeryLazy",
	},
	{ "nushell/tree-sitter-nu", ft = "nu" },
	{
		"lewis6991/satellite.nvim",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{
		"davidmh/mdx.nvim",
		config = true,
		ft = "mdx",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
