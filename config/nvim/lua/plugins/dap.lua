return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      dap.adapters.codelldb = {
        executable = { args = { '--port', '${port}' }, command = 'codelldb' },
        port = '${port}',
        type = 'server',
      }
      dap.set_log_level 'TRACE'
      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap', '-n' },
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', (vim.fn.getcwd() .. '/'), 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
    keys = {
      {
        '<F5>',
        ":lua require'dap'.continue()<CR>",
        silent = true,
      },
      {
        '<F8>',
        ":lua require'dap'.step_over()<CR>",
        silent = true,
      },
      {
        '<F7>',
        ":lua require'dap'.step_into()<CR>",
        silent = true,
      },
      -- {
      --   '<F9>',
      --   ":lua require'dap'.repl.toggle()<CR>",
      --   silent = true,
      -- },
      {
        '<leader>do',
        ":lua require'dapui'.toggle()<CR>",
        silent = true,
        desc = 'dapui toggle',
      },
      {
        '<F2>',
        ":lua require'persistent-breakpoints.api'.toggle_breakpoint()<CR>",
        silent = true,
      },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      { 'theHamsta/nvim-dap-virtual-text', config = true },
      {
        'mfussenegger/nvim-dap-python',
        config = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable((cwd .. '/venv/bin/python')) == 1 then
            cwd = cwd .. '/venv/bin/python'
          elseif vim.fn.executable((cwd .. '/.venv/bin/python')) == 1 then
            cwd = cwd .. '/.venv/bin/python'
          else
            if vim.g.isnixos then
              cwd = '/run/current-system/sw/bin/python'
            else
              cwd = '/usr/bin/python'
            end
          end
          require('dap-python').setup(cwd)
        end,
        keys = {
          {
            '<leader>dm',
            ":lua require('dap-python').test_method()<CR>",
            silent = true,
            ft = 'python',
            desc = 'test method',
          },
          {
            '<leader>dc',
            ":lua require('dap-python').test_class()<CR>",
            silent = true,
            ft = 'python',
            desc = 'test class',
          },
          {
            '<leader>ds',
            "<ESC>:lua require('dap-python').debug_selection()<CR>",
            mode = 'v',
            ft = 'python',
            silent = true,
            desc = 'test selection',
          },
        },
      },
    },
    config = true,
  },
  -- can't lazy load it
  {
    'Weissle/persistent-breakpoints.nvim',
    opts = {
      load_breakpoints_event = { 'BufReadPost' },
    },
    event = 'User DashboardLeave',
  },
}
