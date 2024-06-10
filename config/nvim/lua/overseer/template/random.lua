return {
  name = 'random',
  builder = function()
    return {
      cmd = { 'just' },
      args = { 'test' },
      components = {
        -- { 'on_output_quickfix', set_diagnostics = true, open = true },
        -- 'on_result_diagnostics',
        {
          'dependencies',
          task_names = { { 'shell', cmd = 'just run' } },
          sequential = true,
        },
        { 'restart_on_save', paths = { vim.fn.expand '%:p' } },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'python' },
  },
}
