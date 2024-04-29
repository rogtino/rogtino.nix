vim.loader.enable()
local plugins_path = vim.fn.stdpath 'data' .. '/lazy'
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath 'data' .. '/mason/bin'

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
require('lazy').setup({
  { import = 'plugins' },
  {
    dir = '~/dev/neovim/heyoo/',
    lazy = false,
    -- config = function(_, opts)
    --   print 'config'
    -- end,
    -- opts = function(_, opts)
    --   print 'opts'
    -- end,
  },
  -- {
  --   dir = '~/neovim/heyoo/',
  --   config = function()
  --     print 'son'
  --   end,
  -- },
}, {
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
        --NOTE: can't make zip work,disable all of them ATM
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
  -- checker = { enabled = true },
  -- dev = {
  --   path = "~/dev-nvim/",
  --   patterns = { "rogtino" },
  -- },
})
require 'core'

--TODO: vimtex autopairs octo textobject(treesitter) chatgpt nabla edgy neotest
--TODO: conceal some text
--TODO: there are some useful textobjs like L(url textobjs)...
--draw some insparation from astronvim
