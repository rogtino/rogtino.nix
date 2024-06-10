return {
  name = 'build xmake',
  builder = function()
    return {
      cmd = { 'xmake' },
      components = {
        -- { 'on_output_quickfix', set_diagnostics = true, open = true, close = true },
        -- 'on_result_diagnostics',
        -- {
        --   'dependencies',
        --   task_names = { { 'shell', cmd = 'xmake build' } },
        --   sequential = true,
        -- },
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'cpp', 'c' },
  },
}
