vim.loader.enable()
local plugins_path = vim.fn.stdpath 'data' .. '/lazy'
vim.g.iswin = string.find(vim.uv.os_uname().version, 'Windows')
vim.g.isnixos = vim.fn.filereadable '/etc/nixos/configuration.nix'
vim.env.PATH = vim.env.PATH .. (vim.g.iswin and ';' or ':') .. vim.fn.stdpath 'data' .. '/mason/bin'

local function boot(name, url)
  local package_path = plugins_path .. '/' .. name
  if not vim.uv.fs_stat(package_path) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--single-branch',
      url,
      package_path,
    }
  end
  vim.opt.runtimepath:prepend(package_path)
end

boot('lazy.nvim', 'https://github.com/folke/lazy.nvim.git')
-- TODO:https://github.com/CKolkey/ts-node-action add some node-action
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
require('lazy').setup {
  spec = { { import = 'plugins' } },
  defaults = { lazy = true },
  ui = {
    icons = {
      ft = '',
      lazy = '󰂠 ',
      loaded = '',
      not_loaded = '',
    },
  },
  performance = {
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}
require 'core'

--TODO: vimtex  octo  chatgpt nabla  neotest
--TODO: conceal some text
