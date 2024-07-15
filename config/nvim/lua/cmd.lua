vim.api.nvim_create_user_command('SwitchTheme', function(tb)
  local theme = tb['args']
  if theme == 'dark' then
    vim.o.background = 'dark'
    local previous_theme = vim.g.current_theme
    local tmp_table = vim.tbl_filter(function(it)
      return it ~= previous_theme
    end, vim.g.all_colors[theme])
    local random_selected = tmp_table[math.random(#tmp_table)]
    if string.match(random_selected, 'bamboo') then
      vim.cmd.colorscheme 'bamboo'
    end
    vim.cmd.colorscheme(random_selected)
    vim.g.current_theme = random_selected
    vim.notify('switching to dark theme: ' .. random_selected, vim.log.levels.INFO, {})
  elseif theme == 'light' then
    vim.o.background = 'light'
    local previous_theme = vim.g.current_theme
    local tmp_table = vim.tbl_filter(function(it)
      return it ~= previous_theme
    end, vim.g.all_colors[theme])
    local random_selected = tmp_table[math.random(#tmp_table)]
    if string.match(random_selected, 'bamboo') then
      vim.cmd.colorscheme 'bamboo'
    end
    vim.cmd.colorscheme(random_selected)
    vim.g.current_theme = random_selected
    vim.notify('switching to light theme: ' .. random_selected, vim.log.levels.INFO, {})
  else
    vim.notify('apply dark or light', vim.log.levels.ERROR, {})
  end
end, { nargs = 1 })

vim.api.nvim_create_user_command('LuaSnipEdit', function()
  require('luasnip.loaders').edit_snippet_files()
end, {})

--TODO: generate this inside flake
vim.api.nvim_create_user_command('FindSqlite3', function()
  vim.system({ vim.fn.stdpath 'config' .. '/locate-sqlite3.nu' }):wait()
end, {})

vim.api.nvim_create_user_command('ToUnix', function()
  local Job = require 'plenary.job'
  local buf_name = vim.api.nvim_buf_get_name(0)
  local res
  Job:new({
    command = 'dos2unix',
    args = { '-O', buf_name },
    on_exit = function(j)
      res = j:result()
    end,
  }):sync()
  vim.api.nvim_buf_set_lines(0, 0, -1, true, res)
end, {})

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting globally
    vim.g.disable_autoformat = true
  else
    vim.b.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

vim.api.nvim_create_user_command('Toilet', function()
  vim.o.shell = 'bash'
  vim.cmd '.!toilet -f future'
  vim.o.shell = 'nu'
end, {
  desc = 'format current line with toilet',
})
