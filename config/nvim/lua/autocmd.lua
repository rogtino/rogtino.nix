local userlspocnfig = vim.api.nvim_create_augroup('UserLspConfig', {})
-- this is to fix bug: https://github.com/folke/which-key.nvim/issues/476
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set up neorg Which-Key descriptions',
  group = vim.api.nvim_create_augroup('neorg_mapping_descriptions', { clear = true }),
  pattern = 'norg',
  callback = function()
    vim.keymap.set('n', '<localleader>', function()
      require('which-key').show ','
    end, { buffer = true })
  end,
})

-- vim.api.nvim_create_autocmd('RecordingEnter', {
--   callback = function()
--     vim.notify('󰻃 record to ' .. vim.fn.reg_recording(), vim.log.levels.INFO, {
--       title = 'Recording',
--       render = 'compact',
--       stages = 'fade',
--     })
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('RecordingLeave', {
--   callback = function()
--     vim.notify('󰻃 bye ~', vim.log.levels.INFO, {
--       title = 'Recording',
--       render = 'compact',
--       stages = 'fade',
--     })
--   end,
-- })

vim.api.nvim_create_autocmd('LspAttach', {
  pattern = '*',
  group = userlspocnfig,
  callback = function()
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'go to declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'go to definition' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'go to implementation' })
    vim.keymap.set('n', '<c-leftmouse>', vim.lsp.buf.declaration)
    vim.keymap.set('n', '<c-rightmouse>', '<c-o>')
    vim.keymap.set('n', '<rightmouse>', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, { desc = 'code action' })
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'rename symbol' })
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.incoming_calls, { desc = 'incoming calls' })
    vim.keymap.set('n', '<leader>lo', vim.lsp.buf.outgoing_calls, { desc = 'outgoing calls' })
    vim.keymap.set('n', '<leader>lm', vim.cmd.LspInfo, { desc = 'lspinfo' })
    vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'open current diagnostic' })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'WildMenu', timeout = 400 }
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'readme.norg',
  callback = function()
    vim.cmd 'Neorg export to-file readme.md'
  end,
})

vim.filetype.add {
  extension = {
    lock = 'json',
    mdx = 'mdx',
    mpp = 'cpp',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'startuptime',
    'qf',
    'lspinfo',
    'man',
    'query',
    'checkhealth',
    'toggleterm',
    'NeogitCommitMessage',
    'norg',
    'markdown',
    'spectre_panel',
  },
  callback = function()
    vim.keymap.set('n', 'q', vim.cmd.quit, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'xmake.lua',
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

local change_on_disk = vim.api.nvim_create_augroup('ChangeOnDisk', {})
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = change_on_disk,
  callback = function()
    if vim.fn.mode ~= 'c' then
      vim.cmd.checktime()
    end
  end,
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = change_on_disk,
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.INFO)
  end,
})
