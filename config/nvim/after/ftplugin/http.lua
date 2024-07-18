local kulala = require 'kulala'
vim.keymap.set('n', '<c-j>', kulala.jump_next, { buffer = 0 })
vim.keymap.set('n', '<c-k>', kulala.jump_prev, { buffer = 0 })
vim.keymap.set('n', 'r', kulala.run, { buffer = 0 })
vim.keymap.set('n', 't', kulala.toggle_view, { buffer = 0 })
