vim.diagnostic.config {
  underline = { severity = { min = vim.diagnostic.severity.INFO } },
  signs = {
    severity = { min = vim.diagnostic.severity.HINT },
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  virtual_text = { severity = { min = vim.diagnostic.severity.INFO } },
  -- virtual_text = false,
  virtual_lines = { only_current_line = false, highlight_whole_line = false },
  float = { source = true, show_header = false },
  severity_sort = true,
  update_in_insert = true,
}

vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
