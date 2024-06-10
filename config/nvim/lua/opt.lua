vim.g['loaded_ruby_provider'] = 0
vim.g['loaded_perl_provider'] = 0
local opt = vim.opt
opt.list = true
opt.jumpoptions = 'stack'
opt.listchars = { tab = '> ', nbsp = '␣', trail = '•' }
opt.guicursor = 'n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20'
opt.fillchars = {
  -- eob = " ",
  vert = '║',
  horiz = '═',
  horizup = '╩',
  horizdown = '╦',
  vertleft = '╣',
  vertright = '╠',
  verthoriz = '╬',
  foldopen = '',
  foldclose = '',
}
opt.ruler = false
opt.equalalways = false
opt.wildignorecase = true
opt.swapfile = false
opt.writebackup = false
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.cursorline = false
opt.relativenumber = true
opt.linebreak = true
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.confirm = true
opt.title = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.showmode = false
opt.undofile = true
-- opt.laststatus = 0
opt.signcolumn = 'number'
opt.numberwidth = 4
opt.scrolloff = 99
opt.softtabstop = 2
opt.tabstop = 4
opt.shiftwidth = 2
opt.mouse = 'nv'
opt.completeopt = 'menuone,noselect'
-- opt.undodir = "~/.vim/undodir"
opt.conceallevel = 2
opt.whichwrap = 'h,l'
opt.cmdheight = 0
opt.virtualedit = 'block'
opt.timeoutlen = 500
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.splitkeep = 'screen'
opt.foldcolumn = '1'
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr'
-- opt.statuscolumn = "%s%C"
opt.showbreak = '  󰘍'
opt.shell = 'nu'
-- opt.shell = 'fish'
if vim.g.iswin then
  opt.shellcmdflag = '-c'
  opt.shellquote = ''
  opt.shellxquote = ''
end
opt.shortmess:append { I = true, r = true }
opt.diffopt:append 'linematch:60' -- enable linematch diff algorithm
opt.formatoptions:append 'r'
-- opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste '+',
    ['*'] = require('vim.ui.clipboard.osc52').paste '*',
  },
}
