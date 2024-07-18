local conditions = require 'heirline.conditions'
local statusline = require 'arrow.statusline'
local utils = require 'heirline.utils'

local icons = require('plugins.heirline.common').icons
-- local separators = require('plugins.heirline.common').separators

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = 'N',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'V',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'T',
    },
  },
  provider = function(self)
    return '👾' .. '%2(' .. self.mode_names[self.mode] .. '%)'
  end,
  hl = function(self)
    local color = self:mode_color()
    return { fg = color, bold = true }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd 'redrawstatus'
    end),
  },
}

local Arrow = {
  condition = function()
    return statusline.is_on_arrow_file() ~= nil
  end,
  provider = function()
    return statusline.text_for_statusline_with_icons() .. ' '
  end,
  hl = 'ErrorMsg',
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
    if self.lfilename == '' then
      self.lfilename = '[No Name]'
    end
    if not conditions.width_percent_below(#self.lfilename, 0.27) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
    end
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = utils.get_highlight('Directory').fg, bold = true, italic = true }
    end
    return 'Directory'
  end,
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' ● ', --[+]",
    hl = { fg = 'green' },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = '',
    hl = { fg = 'orange' },
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileIcon,
  FileName,
  unpack(FileFlags),
}

local FileType = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = 'Type',
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= 'utf-8' and enc:upper() .. ' '
  end,
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= 'unix' and fmt:upper()
  end,
}

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = '%5(%c:%l/%L%) %P',
}

local ScrollBar = {
  static = {
    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'blue', bg = 'bright_bg' },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'WinEnter' },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
      table.insert(names, server.name)
    end
    return icons.lsp .. '[' .. unpack(names) .. ']'
  end,
  hl = { fg = 'green', bold = true },
  on_click = {
    name = 'heirline_LSP',
    callback = function()
      vim.schedule(function()
        vim.cmd 'LspInfo'
      end)
    end,
  },
}

local LspProgress = {
  hl = { fg = 'pink', bold = true },
  provider = function()
    return ' ' .. string.sub(require('lsp-progress').progress() or '', 8)
  end,
  update = {
    'User',
    pattern = 'LspProgressStatusUpdated',
    callback = vim.schedule_wrap(function()
      vim.cmd 'redrawstatus'
    end),
  },
}
local Diagnostics = {
  condition = conditions.has_diagnostics,
  update = { 'DiagnosticChanged', 'BufEnter' },
  init = function(self)
    if vim.diagnostic.is_enabled() then
      self.diagnostics = vim.diagnostic.count()
    else
      self.diagnostics = {}
    end
  end,
  {
    provider = function(self)
      return self.diagnostics[1] and (' ' .. self.diagnostics[1] .. ' ')
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      return self.diagnostics[2] and (' ' .. self.diagnostics[2] .. ' ')
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      return self.diagnostics[3] and (' ' .. self.diagnostics[3] .. ' ')
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      return self.diagnostics[4] and ('󰌵 ' .. self.diagnostics[4] .. ' ')
    end,
    hl = 'DiagnosticHint',
  },
}

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd 'Neogit'
      end, 100)
    end,
    name = 'heirline_git',
    update = false,
  },
  hl = { fg = 'orange' },
  {
    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ' ',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (' ' .. count .. ' ')
    end,
    -- hl = 'diffAdded',
    hl = { fg = 'green' },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (' ' .. count .. ' ')
    end,
    -- hl = 'diffDeleted',
    hl = { fg = 'red' },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (' ' .. count .. ' ')
    end,
    -- hl = 'diffChanged',
    hl = { fg = 'orange' },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ' ',
  },
}

local Snippets = {
  condition = function()
    return vim.tbl_contains({ 's', 'i' }, vim.fn.mode())
  end,
  provider = function()
    local forward = require('luasnip').jumpable(1) and ' ' or ''
    local backward = require('luasnip').jumpable(-1) and ' ' or ''
    return backward .. forward
  end,
  hl = { fg = 'red', bold = true },
}

local DAPMessages = {
  condition = function()
    local session = require('dap').session()
    return session ~= nil
  end,
  provider = function()
    return icons.debug .. require('dap').status() .. ' '
  end,
  hl = 'Debug',
  {
    provider = ' ',
    on_click = {
      callback = function()
        require('dap').step_into()
      end,
      name = 'heirline_dap_step_into',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    on_click = {
      callback = function()
        require('dap').step_out()
      end,
      name = 'heirline_dap_step_out',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    on_click = {
      callback = function()
        require('dap').step_over()
      end,
      name = 'heirline_dap_step_over',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'green' },
    on_click = {
      callback = function()
        require('dap').run_last()
      end,
      name = 'heirline_dap_run_last',
    },
  },
  { provider = ' ' },
  {
    provider = ' ',
    hl = { fg = 'red' },
    on_click = {
      callback = function()
        require('dap').terminate()
        require('dapui').close {}
      end,
      name = 'heirline_dap_close',
    },
  },
  { provider = ' ' },
  --       ﰇ  
}

local WorkDir = {
  init = function(self)
    self.icon = icons.dir
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ':~')
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { fg = 'blue', bold = true },
  on_click = {
    callback = function()
      vim.cmd 'Neotree toggle'
    end,
    name = 'heirline_workdir',
  },
  flexible = 1,
  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. self.cwd .. trail .. ' '
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == '/' and '' or '/'
      return self.icon .. cwd .. trail .. ' '
    end,
  },
}

local HelpFilename = {
  condition = function()
    return vim.bo.filetype == 'help'
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ':t')
  end,
  hl = 'Directory',
}

local TerminalName = {
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
      return ' ' .. tname
    end,
    hl = { fg = 'blue', bold = true },
  },
  { provider = ' - ' },
  {
    provider = function()
      return vim.b.term_title
    end,
  },
}

local SearchCount = {
  condition = function()
    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    return string.format(' %d/%d', search.current, math.min(search.total, search.maxcount))
  end,
  hl = { fg = 'purple', bold = true },
}

local MacroRec = {
  condition = function()
    return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
  end,
  provider = ' ',
  hl = { fg = 'orange', bold = true },
  utils.surround({ '[', ']' }, nil, {
    provider = function()
      return vim.fn.reg_recording()
    end,
    hl = { fg = 'green', bold = true },
  }),
  update = {
    'RecordingEnter',
    'RecordingLeave',
  },
  { provider = ' ' },
}

local ShowCmd = {
  condition = function()
    return vim.o.cmdheight == 0
  end,
  provider = ':%3.5(%S%)',
  hl = function(self)
    return { bold = true, fg = self:mode_color() }
  end,
}

local Align = { provider = '%=' }
local Space = { provider = ' ' }

ViMode = utils.surround({ '', '' }, 'bright_bg', { MacroRec, ViMode, Snippets, ShowCmd })

local Org = {
  {
    hl = 'Special',
    provider = function()
      local api = require 'orgmode.api'
      local files = api.load()
      local today_all = 0
      local today_todo = 0
      for _, file in ipairs(files) do
        for _, headline in ipairs(file.headlines) do
          if headline.deadline and headline.deadline:is_today() then
            if headline.todo_type == 'DONE' then
              today_todo = today_todo + 1
            end
            today_all = 1 + today_all
          end
        end
      end
      return ' ' .. today_todo .. '/' .. today_all
    end,
  },
  Space,

  {
    hl = 'DiagnosticError',
    provider = function()
      local api = require 'orgmode.api'
      local files = api.load()
      local undone = 0
      for _, file in ipairs(files) do
        for _, headline in ipairs(file.headlines) do
          if headline.deadline and headline.deadline:is_past 'day' then
            if headline.todo_type ~= 'DONE' then
              undone = undone + 1
            end
          end
        end
      end
      return ' ' .. undone
    end,
  },
  update = { 'BufLeave', pattern = '*.org' },
}
local DefaultStatusline = {
  ViMode,
  Space,
  -- Spell,
  -- WorkDir,
  -- FileNameBlock,
  { provider = '%<' },
  -- Space,
  Git,
  Space,
  Org,
  Space,
  Diagnostics,
  Align,
  -- { flexible = 3,   { Navic, Space }, { provider = "" } },
  LSPActive,
  Space,
  LspProgress,
  Align,
  require 'plugins.heirline.seer',
  DAPMessages,
  -- WorkDir,
  -- FileNameBlock,
  -- VirtualEnv,
  Space,
  FileType,
  { flexible = 3, { FileEncoding } },
  Space,
  Arrow,
  Ruler,
  SearchCount,
  Space,
  FileFormat,
  -- FileSize,
  -- FileLastModified,
  ScrollBar,
}

local InactiveStatusline = {
  condition = conditions.is_not_active,
  { hl = { fg = 'gray', force = true }, WorkDir },
  FileNameBlock,
  { provider = '%<' },
  Align,
}

local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches {
      buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'text' },
      filetype = { '^git.*' },
    }
  end,
  FileType,
  { provider = '%q' },
  Space,
  HelpFilename,
  Align,
  Ruler,
  SearchCount,
  Space,
  ScrollBar,
}

-- local GitStatusline = {
--   condition = function()
--     return conditions.buffer_matches {
--       filetype = { '^git.*', 'fugitive', 'gitcommit' },
--     }
--   end,
--   FileType,
--   Space,
--   {
--     provider = function()
--       -- return vim.fn.FugitiveStatusline()
--       return 'aksda'
--     end,
--   },
--   Space,
--   Align,
-- }

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches { buftype = { 'terminal' } }
  end,
  hl = { bg = 'dark_red' },
  { condition = conditions.is_active, ViMode, Space },
  FileType,
  Space,
  TerminalName,
  Align,
}

local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return 'StatusLine'
    else
      return 'StatusLineNC'
    end
  end,
  static = {
    mode_colors = {
      n = 'red',
      i = 'green',
      v = 'cyan',
      V = 'cyan',
      ['\22'] = 'cyan', -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple', -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = 'orange',
      r = 'orange',
      ['!'] = 'red',
      t = 'green',
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or 'n'
      return self.mode_colors[mode]
    end,
  },
  fallthrough = false,
  -- GitStatusline,
  SpecialStatusline,
  TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

return {
  statusline = StatusLines,
}
