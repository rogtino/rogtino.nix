-- local userlspocnfig = vim.api.nvim_create_augroup('UserLspConfig', {})
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

-- vim.api.nvim_create_autocmd('LspAttach', {
--   pattern = '*',
--   group = userlspocnfig,
--   callback = function()
--     vim.keymap.set('n', '<c-leftmouse>', vim.lsp.buf.declaration)
--     vim.keymap.set('n', '<c-rightmouse>', '<c-o>')
--     vim.keymap.set('n', '<rightmouse>', vim.lsp.buf.hover)
--   end,
-- })

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
    ua = 'uiua',
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
    'org',
    'text',
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

vim.api.nvim_create_autocmd({ 'BufUnload' }, {
  group = vim.api.nvim_create_augroup('RogInteral', { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value('filetype', { buf = args.buf })

    if buftype == 'dashboard' then
      vim.api.nvim_exec_autocmds('User', { pattern = 'DashboardLeave', modeline = false })
      vim.api.nvim_del_augroup_by_name 'RogInteral'
    end
  end,
})
