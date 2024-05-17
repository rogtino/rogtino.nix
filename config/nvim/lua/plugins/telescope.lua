return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'benfowler/telescope-luasnip.nvim',
    {
      'AckslD/nvim-neoclip.lua',
      dependencies = 'kkharji/sqlite.lua',
      config = true,
      -- lazy = false,
      event = 'TextYankPost',
      keys = {
        { '<leader>pn', ':Telescope neoclip<CR>', desc = 'pick neoclip' },
      },
    },
    -- not compatiable with flake
    -- see:https://github.com/mlvzk/manix/issues/25
    -- {
    -- 	"MrcJkb/telescope-manix",
    -- 	keys = {
    -- 		{ "<leader>hn", "<ESC>:Telescope manix<CR>", desc = "help for nix functions" },
    -- 	},
    -- },
    {
      'mrjones2014/tldr.nvim',
      keys = { { '<leader>ht', ':Telescope tldr<CR>', desc = 'tldr' } },
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'LinArcX/telescope-env.nvim',
    'LinArcX/telescope-ports.nvim',
    {
      'prochri/telescope-all-recent.nvim',
      config = true,
      dependencies = {
        'kkharji/sqlite.lua',
        lazy = true,
        config = function()
          if string.find(vim.uv.os_uname().version, 'NixOS') then
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
      '<leader>pe',
      function()
        return vim.cmd.Telescope 'env'
      end,
      desc = 'pick-env',
    },
    {
      '<leader>pb',
      function()
        vim.cmd.Telescope 'buffers'
      end,
      desc = 'pick-buffer',
    },
    { '<leader>hh', ':Telescope help_tags<CR>', desc = 'help', silent = true },
    {
      '<leader>pm',
      function()
        return vim.cmd 'Telescope man_pages sections=ALL'
      end,
      desc = 'pick-man-page',
    },
    {
      '<leader>sn',
      function()
        return vim.cmd 'Telescope notify'
      end,
      desc = 'search notify',
    },
  },
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'smart' },
        file_ignore_patterns = { '.git/', 'node_modules' },
        layout_strategy = 'center',
        border = false,
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
    }
    telescope.load_extension 'ui-select'
    telescope.load_extension 'luasnip'
    telescope.load_extension 'env'
    telescope.load_extension 'ports'
  end,
}
