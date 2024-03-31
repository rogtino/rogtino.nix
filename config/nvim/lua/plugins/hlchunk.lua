local ex = { help = true, yuck = true, alpha = true, oil = true, dapui_scopes = true }
return {
	"shellRaining/hlchunk.nvim",
	event = "UIEnter",
	opts = {
		blank = { exclude_filetypes = ex, enable = false },
		chunk = { enable = true, exclude_filetypes = ex },
		line_num = { enable = true, exclude_filetypes = ex },
		indent = { support_filetypes = { python = true }, enable = false },
	},
}
