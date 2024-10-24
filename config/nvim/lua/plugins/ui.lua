local ex = {
  help = true,
  yuck = true,
  alpha = true,
  oil = true,
  oil_preview = true,
  ssr = true,
  org = true,
  orgagenda = true,
  orghelp = true,
  dapui_scopes = true,
  NeogitCommitMessage = true,
  NeogitConsole = true,
  NeogitStatus = true,
  ['neo-tree-popup'] = true,
  text = true,
  conf = true,
  trouble = true,
  swayconfig = true,
}
return {
  -- {
  -- 	"nvim-zh/colorful-winsep.nvim",
  -- 	config = true,
  -- 	event = "VeryLazy",
  -- },
  {
    '3rd/image.nvim',
    config = true,
    ft = { 'markdown', 'norg' },
    -- enabled = vim.g.isnixos == 0,
    enabled = false,
    -- dependencies = { 'luarocks.nvim' },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = true,
      },
    },
    event = 'User DashboardLeave',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
    },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      close_if_last_window = false,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>ee', '<cmd>Neotree toggle dir=./ position=left<CR>', desc = 'neotree-root-toggle' },
      { '<leader>er', '<cmd>Neotree reveal toggle position=left<CR>', desc = 'neotree-reveal-toggle' },
      { '<leader>ef', '<cmd>Neotree reveal toggle position=float<CR>', desc = 'neotree-float-toggle' },
    },
  },
  { 'stevearc/dressing.nvim', config = true },
  { 'echasnovski/mini.cursorword', config = true, event = 'User DashboardLeave' },
  {
    'rcarriga/nvim-notify',
    opts = {
      fps = 60,
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'User DashboardLeave',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>bo', vim.cmd.BufferLineCloseOthers, desc = 'delete other buffers' },
      { '<leader>bp', vim.cmd.BufferLinePick, desc = "pick a buffer by buf's name" },
      { '<leader>bd', vim.cmd.Bdelete, desc = 'delete current buffer' },
      {
        '<leader>ba',
        function()
          vim.cmd '%bd'
        end,
        desc = 'delete all buffers',
      },
      { '<s-l>', vim.cmd.BufferLineCycleNext },
      { '<s-h>', vim.cmd.BufferLineCyclePrev },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
          local icon = ((level:match 'error' and ' ') or ' ')
          return (' ' .. icon .. count)
        end,
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup { preset = 'classic' }
      require('which-key').add {
        { '<leader>t', group = '[T]oggle', icon = '' },
        { '<leader>b', group = '[B]uffer', icon = '󰆠' },
        { '<leader>l', group = '[L]sp', icon = '󱁤' },
        -- TODO: combine overlaps between search and picker
        { '<leader>s', group = '[S]earch', icon = '' },
        { '<leader>g', group = '[G]it', icon = '󰊢' },
        { '<leader>h', group = '[H]elp', icon = '󰋖' },
        { '<leader>r', group = '[R]un', icon = '' },
        { '<leader>w', group = '[W]indow', icon = '' },
        { '<leader>p', group = '[P]icker', icon = '󰛔' },
        { '<leader>d', group = '[D]ap', icon = '' },
        { '<leader>n', group = '[N]ote-roam', icon = '󰂺' },
        { '<leader>o', group = '[O]rg', icon = '' },
        { '<leader>rg', group = '[G]en', icon = '' },
        { '<leader>e', group = 'N[e]otree', icon = '' },
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    event = 'User DashboardLeave',
    keys = {
      {
        '<leader>st',
        vim.cmd.TodoTrouble,
        desc = 'search all todo comments',
      },
    },
  },
  -- {
  --   'VidocqH/lsp-lens.nvim',
  --   config = true,
  --   event = 'LspAttach',
  -- },
  -- {
  -- 	"edluffy/hologram.nvim",
  -- 	opts = { auto_display = true },
  -- 	event = "VeryLazy",
  -- },
  {
    'tzachar/highlight-undo.nvim',
    config = true,
    keys = { 'u', '<c-r>' },
  },
  { 'folke/twilight.nvim', config = true, cmd = { 'Twilight' } },
  -- {
  -- 	"RaafatTurki/hex.nvim",
  -- 	config = true,
  -- 	cmd = "HexToggle",
  -- },
  {
    'nacro90/numb.nvim',
    config = true,
    keys = ':',
  },
  {
    'shellRaining/hlchunk.nvim',
    event = 'User DashboardLeave',
    opts = {
      blank = { exclude_filetypes = ex, enable = false },
      chunk = { enable = true, exclude_filetypes = ex },
      line_num = { enable = true, exclude_filetypes = ex },
      indent = { support_filetypes = { python = true }, enable = false },
    },
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['cmp.entry.get_documentation'] = true,
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
        hover = {
          silent = true,
        },
      },
      routes = {
        {
          -- filter = {
          --   any = { { find = '%d+L, %d+B' }, { find = '; after #%d+' }, { find = '; before #%d+' } },
          --   event = 'msg_show',
          -- },
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          view = 'mini',
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
      cmdline = { view = 'cmdline' },
    },
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95,
        width = 0.8,
        height = 1,
        options = {
          -- signcolumn = 'yes',
          number = false,
          relativenumber = false,
          foldcolumn = '0',
          cursorline = false,
        },
      },
      plugins = {
        gitsigns = { enabled = true },
        alacritty = {
          enabled = true,
          font = '18', -- font size
        },
      },
    },
    cmd = 'ZenMode',
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        footer = { '', '', '🥰 calm and hungry', '🎯 orgorgorg' },
        project = { enable = false },
        shortcut = {
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            desc = '󰛔 Files',
            group = 'Label',
            action = function()
              vim.cmd.Lazy 'load nvim-treesitter'
              vim.cmd.Telescope 'find_files'
            end,
            key = 's',
          },
          {
            group = 'WarningMsg',
            desc = '󰯉 grep',
            action = function()
              vim.cmd.Lazy 'load nvim-treesitter'
              vim.cmd.Telescope 'live_grep'
            end,
            key = 'f',
          },
          {
            desc = ' org',
            group = 'Define',
            action = function()
              require('orgmode').agenda:prompt()
            end,
            key = 'o',
          },
          {
            desc = '󰳗 capture',
            group = 'Statement',
            action = function()
              require('orgmode').capture:prompt()
            end,
            key = 'c',
          },
          {
            desc = '󰂺 roam',
            group = 'Number',
            action = function()
              require('org-roam').api.find_node()
            end,
            key = 'r',
          },
          {
            desc = '󰃨 sessoin',
            group = '@type',
            action = 'SessionManager load_current_dir_session',
            key = 'e',
          },
          {
            desc = '󰈻 select',
            group = '@function.method',
            action = 'SessionManager load_session',
            key = 'l',
          },
          {
            desc = '󱚝 exit',
            group = 'Special',
            action = 'quit',
            key = 'q',
          },
        },
      },
    },
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'FabijanZulj/blame.nvim',
    opts = {},
    cmd = 'BlameToggle',
    keys = { { '<leader>tb', vim.cmd.BlameToggle, desc = 'toggle blame' } },
  },
  {
    'topaxi/gh-actions.nvim',
    keys = {
      { '<leader>gh', '<cmd>GhActions<cr>', desc = 'Open Github Actions' },
    },
    opts = {},
  },
}
