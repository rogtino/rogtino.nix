return {
	"nvim-orgmode/orgmode",

	dependencies = { "nvim-treesitter/nvim-treesitter", { "akinsho/org-bullets.nvim", config = true } },
	event = "VeryLazy",
	opts = { org_agenda_files = "~/orgfiles/**/*", org_default_notes_file = "~/orgfiles/refile.org" },
}
