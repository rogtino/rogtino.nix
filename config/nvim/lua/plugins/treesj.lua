--  ;; Edit language injection
--  ; (pack :AckslD/nvim-FeMaco.lua {:config true})
--  ; (pack :abecodes/tabout.nvim
--  ;       {:dependencies [:nvim-treesitter :nvim-cmp]
--  ;        :config true
--  ;        :event :VeryLazy
--  ;        :opts {:act_as_shift_tab false
--  ;               :act_as_tab true
--  ;               :backwards_tabkey :<S-Tab>
--  ;               :completion true
--  ;               :default_shift_tab :<C-d>
--  ;               :default_tab :<C-t>
--  ;               :enable_backwards true
--  ;               :exclude {}
--  ;               :ignore_beginning true
--  ;               :tabkey :<Tab>
--  ;               :tabouts [{:close "'" :open "'"}
--  ;                         {:close "\"" :open "\""}
--  ;                         {:close "`" :open "`"}
--  ;                         {:close ")" :open "("}
--  ;                         {:close "]" :open "["}
--  ;                         {:close "}" :open "{"}]}})
--  ; Align text interactively
--  ;TODO learn how to use it
return {
	"nmac427/guess-indent.nvim",
	{
		"echasnovski/mini.align",
		config = true,
		keys = {
			{
				"ga",
				mode = "v",
				desc = "Align",
			},
			{
				"gA",
				mode = "v",
				desc = "Align with preview",
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = { {
			"<space>j",
			":TSJToggle<CR>",
			desc = "join or split",
		} },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { use_default_keymaps = false },
	},
}
