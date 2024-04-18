-- BUG:winbar lags when scrolling
-- see: https://github.com/neovide/neovide/pull/2438
if vim.g.neovide then
	vim.g["neovide_transparency"] = 0.8
	vim.g["neovide_floating_blur_amount_x"] = 2
	vim.g["neovide_floating_blur_amount_y"] = 2
	vim.g["neovide_fullscreen"] = true
	vim.g["neovide_cursor_animation_length"] = 0.1
	vim.g["neovide_cursor_vfx_mode"] = "ripple"
	vim.o["guifont"] = "IntoneMono_Nerd_Font,Noto_Color_Emoji:h18"
	-- vim.o["guifont"] = "IBM_PLEX_MONO,Noto_Color_Emoji:h18"
end
