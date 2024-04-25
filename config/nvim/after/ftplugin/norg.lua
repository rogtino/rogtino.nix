-- vim.wo.spell = true
-- vim.bo.spelllang = "en"
local map = function(a, b)
    vim.keymap.set('n', a, b, { silent = true, buffer = true })
end
-- map("0", ":Neorg kanban toggle<CR>")
-- map("1", ":Neorg gtd capture<CR>")
-- map("2", ":Neorg gtd edit<CR>")
-- map("3", ":Neorg gtd views<CR>")
map('<localleader>ct', ':Neorg toc split<CR>')
map('<localleader>p', ':Neorg presenter start<CR>')
map('<localleader>mt', ':Neorg inject-metadata<CR>')
map('<localleader>cc', ':Neorg toggle-concealer<CR>')
