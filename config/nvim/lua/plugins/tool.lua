return {
  -- {
  --   "LintaoAmons/bookmarks.nvim",
  --   dependencies = {
  --     { "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
  --   },
  --   keys = {
  --     { "ms", "<Cmd>BookmarksGoto<CR>", mode = { "n" }, desc = "select a bookmark" },
  --     { "ma", "<Cmd>BookmarksMark<CR>", mode = { "n" }, desc = "add a bookmark" },
  --   },
  --   lazy = false,
  -- },
  {
    'stevearc/oil.nvim',
    opts = {
      use_default_keymaps = true,
      keymaps = {
        ['<TAB>'] = 'actions.select',
        ['<C-s>'] = false,
        ['<C-e>'] = 'actions.select_vsplit',
        ['<C-c>'] = false,
        ['q'] = 'actions.close',
        ['..'] = 'actions.toggle_hidden',
        ['g.'] = false,
      },
      experimental_watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
    keys = { { '<c-e>', vim.cmd.Oil, desc = 'open oil' } },
  },
  -- {
  --   'Mythos-404/xmake.nvim',
  --   lazy = true,
  --   event = 'BufReadPost xmake.lua',
  --   opts = {
  --     compile_command = {
  --       lsp = 'clangd',
  --       dir = '.',
  --     },
  --   },
  --   dependencies = { 'MunifTanjim/nui.nvim' },
  -- },
  {
    'mbbill/undotree',
    keys = { { '<leader>tu', vim.cmd.UndotreeToggle, desc = 'toggle undo tree' } },
  },
  {
    'tpope/vim-eunuch',
    cmd = 'Mkdir',
  },
  {
    'ellisonleao/carbon-now.nvim',
    opts = {
      options = {
        theme = 'one-dark',
        bg = 'pink',
        font_family = 'Cascadia Code',
        titlebar = 'made by pypro',
        drop_shadow = true,
      },
    },
    cmd = 'CarbonNow',
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      picker = 'fzf-lua',
    },
    cmd = 'Octo',
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'User DashboardLeave',
    ft = 'org',
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'next git change' })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'previous git change' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'stage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'reset hunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage hunk' })
        map('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'stage buffer' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'reset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview hunk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = 'blame line' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'diff this' })
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { desc = 'diff ~' })
        map('n', '<leader>gt', gs.toggle_deleted, { desc = 'toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    'sindrets/diffview.nvim',
    config = true,
    keys = {
      { '<leader>go', vim.cmd.DiffviewOpen, desc = 'open diffview' },
      { '<leader>gc', vim.cmd.DiffviewClose, desc = 'close diffview' },
    },
  },

  --not free :(
  --( pack :zbirenbaum/copilot.lua {:cmd :Copilot :event :InsertEnter :config true })
  {
    'famiu/bufdelete.nvim',
    cmd = 'Bdelete',
  },
  -- "mong8se/actually.nvim",
  -- { "chrisgrieser/nvim-early-retirement", config = true, event = "VeryLazy" },
  -- { 'Civitasv/cmake-tools.nvim', config = true, cmd = { 'CMakeGenerate', 'CMakeBuild', 'CMakeRun', 'CMakeRunTest' } },
  {
    'stevearc/overseer.nvim',
    -- config = function(_, opts)
    --   vim.g.overseer_loaded = true
    --   require('overseer').setup(opts)
    -- end,
    dependencies = { 'stevearc/dressing.nvim' },
    opts = {
      templates = { 'builtin', 'cmake', 'run_script', 'xmake' },
      task_list = {
        bindings = {

          ['K'] = 'ScrollOutputUp',
          ['J'] = 'ScrollOutputDown',
        },
      },
      -- actions = {
      --   ['70vsplit'] = {
      --     desc = 'open terminal in a vertical split',
      --     condition = function(task)
      --       local bufnr = task:get_bufnr()
      --       return bufnr and vim.api.nvim_buf_is_valid(bufnr)
      --     end,
      --     run = function(task)
      --       local util = require 'overseer.util'
      --       vim.cmd [[70vsplit]]
      --       util.set_term_window_opts()
      --       vim.api.nvim_win_set_buf(0, task:get_bufnr())
      --       util.scroll_to_end(0)
      --     end,
      --   },
      -- },
    },
    keys = {
      {
        '<leader>ra',
        vim.cmd.OverseerQuickAction,
        mode = 'n',
        desc = 'run QuickAction',
      },
      {
        '<leader>rb',
        '<CMD>OverseerBuild<CR>',
        mode = 'n',
        desc = 'run Build',
      },
      {
        '<leader>rt',
        '<CMD>OverseerToggle<CR>',
        mode = 'n',
        desc = 'run Toggle',
      },
      {
        '<leader>rk',
        '<CMD>OverseerTaskAction<CR>',
        mode = 'n',
        desc = 'run TaskAction',
      },
      {
        '<leader>ri',
        '<CMD>OverseerInfo<CR>',
        mode = 'n',
        desc = 'run info',
      },
      {
        '<leader>rc',
        '<CMD>OverseerRunCmd<CR>',
        mode = 'n',
        desc = 'run Cmd',
      },
      {
        '<leader>ro',
        '<CMD>OverseerRun<CR>',
        mode = 'n',
        desc = 'run Overseer',
      },
    },
  },
  -- {
  -- 	"rogtino/codebase.nvim",
  -- 	config = true,
  -- 	keys = { { "<leader>sc", ":Telescope codebase<CR>", desc = "search a piece of code" } },
  -- },
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    init = function()
      vim.g.disable_autoformat = false
    end,
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        javascript = { 'biome' },
        java = { 'google-java-format' },
        json = { 'biome' },
        c = { 'clang_format' },
        css = { 'biome' },
        cpp = { 'clang_format' },
        typescript = { 'biome' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        toml = { 'taplo' },
        typst = { 'typstfmt' },
        javascriptreact = { 'biome', 'rustywind' },
        typescriptreact = { 'biome', 'rustywind' },
        python = { 'black' },
        fennel = { 'fnlfmt' },
        nix = { 'alejandra' },
      },
      formatters = {
        fnlfmt = { command = 'fnlfmt', args = { '$FILENAME' }, stdin = true },
        biome = {
          inherit = false,
          command = 'biome',
          stdin = true,
          args = { 'format', '--indent-style=space', '--indent-width=2', '--stdin-file-path', '$FILENAME' },
        },
      },
      format_after_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = 'fallback', quiet = true }
      end,
    },
  },
  {
    'JuanZoran/Trans.nvim',
    keys = {
      {
        '<leader>z',
        '<Cmd>Translate<CR>',
        mode = { 'n', 'x' },
        desc = '󰊿 Translate',
      },
      -- { 'mi', '<Cmd>TranslateInput<CR>', desc = '󰊿 Translate From Input' },
    },
    build = function()
      require('Trans').install()
    end,
    opts = {
      frontend = {
        default = {
          animation = {
            interval = 0,
            open = 'fold',
            close = 'fold',
          },
        },
      },
    },
    dependencies = 'kkharji/sqlite.lua',
  },
  {
    'williamboman/mason.nvim',
    config = true,
    cmd = 'Mason',
    build = ':MasonUpdate',
    enabled = vim.g.isnixos == 0,
  },
  -- {
  -- 	dir = "~/dev-nvim/tslt.nvim",
  -- },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    -- branch = 'nightly',
    cmd = 'Neogit',
    keys = {
      {
        '<leader>gn',
        '<cmd>Neogit<CR>',
        mode = 'n',
        desc = 'Neogit',
      },
    },
  },
  -- { "max397574/better-escape.nvim", config = true },
  {
    'smoka7/multicursors.nvim',
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  {
    'monaqa/dial.nvim',
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%Y年%-m月%-d日'],
          augend.date.alias['%H:%M'],
          augend.constant.new {
            elements = { 'True', 'False' },
            word = true,
            preserve_case = true,
            cyclic = true,
          },
        },
      }
    end,
    keys = {
      {
        '<C-a>',
        '<Plug>(dial-increment)',
        { mode = { 'n', 'v' } },
      },
      {
        '<C-x>',
        '<Plug>(dial-decrement)',
        { mode = { 'n', 'v' } },
      },
    },
  },
  {
    'Shatur/neovim-session-manager',
    cmd = 'SessionManager',
    keys = {
      {
        '<leader>le',
        '<cmd>SessionManager load_session<CR>',
        desc = 'load session',
      },
      {
        '<leader>la',
        '<cmd>SessionManager load_last_session<CR>',
        desc = 'load last session',
      },
    },
    event = 'User DashboardLeave',
    config = true,
    -- config = function()
    --   local config = require 'session_manager.config'
    --   require('session_manager').setup { autoload_mode = config.AutoloadMode.CurrentDir }
    -- end,
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = '<c-t>',
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
      -- shell = 'fish',
      shell = 'nu',
      float_opts = {
        border = 'curved',
        winblend = 3,
        highlights = {
          FloatBorder = { link = 'FloatBorder' },
          NormalFloat = { link = 'NormalFloat' },
        },
      },
      winbar = {
        enabled = true,
      },
    },
    keys = {
      {
        '<leader>th',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local htop = Terminal:new { cmd = 'htop', hidden = true, direction = 'float' }
          return htop:toggle()
        end,
        desc = 'htop',
      },
      {
        '<leader>ty',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local yazi = Terminal:new { cmd = 'yazi', hidden = true, direction = 'float' }
          return yazi:toggle()
        end,
        desc = 'yazi',
      },
      {
        '<leader>tg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
          return lazygit:toggle()
        end,
        desc = 'lazygit',
      },
      {
        '<localleader>r',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local xmake = Terminal:new { cmd = 'xmake run', hidden = true, direction = 'float', close_on_exit = false }
          return xmake:toggle()
        end,
        ft = 'cpp',
        desc = 'xmake run',
      },
      {
        '<leader>t1',
        function()
          vim.cmd '1ToggleTerm'
        end,
        desc = 'open first term',
      },
      {
        '<leader>t2',
        function()
          vim.cmd '2ToggleTerm'
        end,
        desc = 'open second term',
      },
      {
        '<leader>t3',
        function()
          vim.cmd '3ToggleTerm'
        end,
        desc = 'open third term',
      },
      {
        '<leader>t0',
        function()
          vim.cmd '99ToggleTerm direction=float'
        end,
        desc = 'open float term',
      },
      '<c-t>',
    },
    cmd = 'ToggleTerm',
  },
  {
    'echasnovski/mini.align',
    config = true,
    keys = {
      {
        'ga',
        mode = 'v',
        desc = 'Align',
      },
      {
        'gA',
        mode = 'v',
        desc = 'Align with preview',
      },
    },
  },
  -- {
  --   'm4xshen/hardtime.nvim',
  --   dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  --   opts = {
  --     max_count = 3,
  --     disabled_filetypes = { 'qf', 'lazy', 'mason', 'oil', 'sagaoutline', 'trouble' },
  --   },
  --   event = 'VeryLazy',
  -- },
  {
    'mistweaverco/kulala.nvim',
    opts = {},
    ft = 'http',
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {},
    branch = 'regexp',
    ft = 'python',
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
    },
  },
}
