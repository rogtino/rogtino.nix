vim.diagnostic.config {
  underline = { severity = { min = vim.diagnostic.severity.INFO } },
  signs = { severity = { min = vim.diagnostic.severity.HINT } },
  virtual_text = { severity = { min = vim.diagnostic.severity.INFO } },
  -- virtual_text = false,
  virtual_lines = { only_current_line = false, highlight_whole_line = false },
  float = { source = true, show_header = false },
  severity_sort = true,
  update_in_insert = true,
}

vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignOk', { text = ' ', texthl = 'DiagnosticSignOk' })
vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
