local ex = {
  help = true,
  yuck = true,
  alpha = true,
  oil = true,
  oil_preview = true,
  ssr = true,
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
    enabled = false,
    dependencies = { 'luarocks.nvim' },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    event = 'VeryLazy',
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
    keys = {
      { '<leader>tn', '<cmd>Neotree toggle dir=./ position=left<CR>', desc = 'neotree-root-toggle' },
      { '<leader>tr', '<cmd>Neotree reveal toggle position=left<CR>', desc = 'neotree-reveal-toggle' },
      { '<leader>tf', '<cmd>Neotree reveal toggle position=float<CR>', desc = 'neotree-float-toggle' },
    },
  },
  { 'stevearc/dressing.nvim', config = true, event = 'VeryLazy' },
  { 'echasnovski/mini.cursorword', config = true, event = 'VeryLazy' },
  {
    'rcarriga/nvim-notify',
    opts = {
      fps = 60,
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
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
  -- no need :(
  -- {
  -- 	"folke/edgy.nvim",
  -- 	event = "VeryLazy",
  -- 	opts = {
  -- 		bottom = {
  -- 			{
  -- 				filter = function(_, win)
  -- 					return (vim.api.nvim_win_get_config(win).relative == "")
  -- 				end,
  -- 				ft = "toggleterm",
  -- 				size = { height = 0.4 },
  -- 			},
  -- 			{
  -- 				filter = function(buf)
  -- 					return not vim.b[buf].lazyterm_cmd
  -- 				end,
  -- 				ft = "lazyterm",
  -- 				size = { height = 0.4 },
  -- 				title = "LazyTerm",
  -- 			},
  -- 			"Trouble",
  -- 			{ ft = "qf", title = "QuickFix" },
  -- 			{
  -- 				filter = function(buf)
  -- 					return (vim.bo[buf].buftype == "help")
  -- 				end,
  -- 				ft = "help",
  -- 				size = { height = 20 },
  -- 			},
  -- 			{ ft = "spectre_panel", size = { height = 0.4 } },
  -- 		},
  -- 		left = {
  -- 			{
  -- 				filter = function(buf)
  -- 					return (vim.b[buf].neo_tree_source == "filesystem")
  -- 				end,
  -- 				ft = "neo-tree",
  -- 				size = { height = 0.5 },
  -- 				title = "Neo-Tree",
  -- 			},
  -- 			{
  -- 				filter = function(buf)
  -- 					return (vim.b[buf].neo_tree_source == "git_status")
  -- 				end,
  -- 				ft = "neo-tree",
  -- 				open = "Neotree position=right git_status",
  -- 				pinned = true,
  -- 				title = "Neo-Tree Git",
  -- 			},
  -- 			{
  -- 				filter = function(buf)
  -- 					return (vim.b[buf].neo_tree_source == "buffers")
  -- 				end,
  -- 				ft = "neo-tree",
  -- 				open = "Neotree position=top buffers",
  -- 				pinned = true,
  -- 				title = "Neo-Tree Buffers",
  -- 			},
  -- 			{ ft = "Outline", open = "Lspsaga outline", pinned = true },
  -- 			"neo-tree",
  -- 		},
  -- 	},
  -- },
  'folke/which-key.nvim',
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    event = 'VeryLazy',
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
    event = 'VeryLazy',
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
          filter = {
            any = { { find = '%d+L, %d+B' }, { find = '; after #%d+' }, { find = '; before #%d+' } },
            event = 'msg_show',
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
      -- cmdline = { view = 'cmdline' },
    },
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = 'yes',
          number = true,
          relativenumber = true,
          foldcolumn = '0',
          cursorline = false,
        },
      },
      plugins = { gitsigns = { enabled = true } },
    },
    cmd = 'ZenMode',
  },
}
