local function config()
	local augend = require("dial.augend")
	return ((require("dial.config")).augends):register_group({
		default = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.integer.alias.octal,
			augend.integer.alias.binary,
			augend.date.alias["%Y/%m/%d"],
			augend.date.alias["%Y-%m-%d"],
			augend.date.alias["%Y年%-m月%-d日"],
			augend.date.alias["%H:%M"],
			augend.constant.new({ elements = { "True", "False" }, word = true, preserve_case = true, cyclic = true }),
		},
	})
end
return {
	"monaqa/dial.nvim",
	config = config,
	keys = {
		{
			"<C-a>",
			"<Plug>(dial-increment)",
			{ mode = { "n", "v" } },
		},
		{
			"<C-x>",
			"<Plug>(dial-decrement)",
			{ mode = { "n", "v" } },
		},
	},
}
