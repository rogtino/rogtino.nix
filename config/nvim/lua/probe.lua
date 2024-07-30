if vim.g.neovide then
  vim.g['neovide_transparency'] = 0.8
  vim.g['neovide_floating_blur_amount_x'] = 2
  vim.g['neovide_floating_blur_amount_y'] = 2
  vim.g['neovide_fullscreen'] = false
  vim.g['neovide_cursor_animation_length'] = 0.1
  vim.g['neovide_cursor_vfx_mode'] = 'ripple'
  if vim.g.iswin then
    vim.o['guifont'] = 'MartianMono_Nerd_Font,Noto_Color_Emoji'
  else
    vim.o['guifont'] = 'monospace:h8'
  end
  vim.o.scrolloff = 0
  -- vim.o['guifont'] = 'IntoneMono_Nerd_Font,Noto_Color_Emoji:h18'
  -- vim.o["guifont"] = "IBM_PLEX_MONO,Noto_Color_Emoji:h18"
end
