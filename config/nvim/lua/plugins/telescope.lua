return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- not compatiable with flake
      -- see:https://github.com/mlvzk/manix/issues/25
      -- {
      -- 	"MrcJkb/telescope-manix",
      -- 	keys = {
      -- 		{ "<leader>hn", "<ESC>:Telescope manix<CR>", desc = "help for nix functions" },
      -- 	},
      -- },
      {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
          local telescope = require 'telescope'
          telescope.load_extension 'ui-select'
        end,
      },
    },
    cmd = 'Telescope',
    keys = {
      {
        '<leader><leader>',
        function()
          return vim.cmd.Telescope 'find_files'
        end,
        desc = 'find files',
      },
      {
        '<leader>f',
        function()
          return vim.cmd.Telescope 'live_grep'
        end,
        desc = 'live grep',
      },
      {
        '<leader>pb',
        function()
          vim.cmd.Telescope 'buffers'
        end,
        desc = 'pick buffer',
      },
      { '<leader>hh', ':Telescope help_tags<CR>', desc = 'help', silent = true },
      {
        '<leader>pm',
        function()
          return vim.cmd 'Telescope man_pages sections=ALL'
        end,
        desc = 'pick man-page',
      },
      {
        '<leader>pn',
        function()
          return vim.cmd 'Telescope notify'
        end,
        desc = 'pick notify',
      },
    },
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'smart' },
        file_ignore_patterns = { '.git/', 'node_modules' },
        layout_strategy = 'center',
        border = true,
        layout_config = {
          anchor = 'N',
          preview_cutoff = 1,
          prompt_position = 'top',
          width = 0.95,
        },
      },
      pickers = {
        find_files = { find_command = { 'rg', '--hidden', '--glob', '!.git', '--files' } },
        live_grep = { find_command = { 'rg', '--hidden', '--glob', '!.git', '--files' } },
      },
      -- extensions = {
      -- 	codebase = {
      -- 		path = vim.fn.stdpath("config") .. "/codebase",
      -- 	},
      -- },
    },
  },
  {
    'prochri/telescope-all-recent.nvim',
    config = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      {
        'kkharji/sqlite.lua',
        config = function()
          if vim.g.iswin then
            vim.g.sqlite_clib_path = vim.fn.expand '~/sqlite3.dll'
          end
          if vim.g.isnixos then
            local Job = require 'plenary.job'
            local sqlite3_path = vim.fn.stdpath 'config' .. '/sqlite3.path'
            Job:new({
              command = 'cat',
              args = { sqlite3_path },
              on_exit = function(j, _)
                for _, value in ipairs(j:result()) do
                  vim.g.sqlite_clib_path = value
                end
              end,
            }):sync()
          end
        end,
      },
    },
  },

  {
    'AckslD/nvim-neoclip.lua',
    dependencies = 'kkharji/sqlite.lua',
    config = true,
    -- lazy = false,
    event = 'TextYankPost',
    keys = {
      { '<leader>pc', ':Telescope neoclip<CR>', desc = 'pick neoclip' },
    },
  },

  {
    'mrjones2014/tldr.nvim',
    keys = { { '<leader>pt', ':Telescope tldr<CR>', desc = 'pick tldr' } },
  },

  {
    'LinArcX/telescope-env.nvim',
    config = function()
      local telescope = require 'telescope'
      telescope.load_extension 'env'
    end,
    keys = {
      {
        '<leader>pe',
        function()
          return vim.cmd.Telescope 'env'
        end,
        desc = 'pick env',
      },
    },
  },

  {
    'LinArcX/telescope-ports.nvim',
    config = function()
      local telescope = require 'telescope'
      telescope.load_extension 'ports'
    end,
    keys = {
      {
        '<leader>pp',
        function()
          return vim.cmd.Telescope 'ports'
        end,
        desc = 'pick ports',
      },
    },
  },
  {
    'benfowler/telescope-luasnip.nvim',

    config = function()
      local telescope = require 'telescope'
      telescope.load_extension 'luasnip'
    end,
    keys = {

      {
        '<leader>ps',
        function()
          return vim.cmd.Telescope 'luasnip'
        end,
        desc = 'pick snippets',
      },
    },
  },
}
