return {

  'rebelot/heirline.nvim',
  -- You can optionally lazy-load heirline on UiEnter
  -- to make sure all required plugins and colorschemes are loaded before setup
  event = 'UiEnter',
  config = function()
    local conditions = require 'heirline.conditions'
    local utils = require 'heirline.utils'
    local function setup_colors()
      return {
        bright_bg = utils.get_highlight('Folded').bg,
        bright_fg = utils.get_highlight('Folded').fg,
        red = utils.get_highlight('DiagnosticError').fg,
        dark_red = utils.get_highlight('DiffDelete').bg,
        green = utils.get_highlight('String').fg,
        blue = utils.get_highlight('Function').fg,
        gray = utils.get_highlight('NonText').fg,
        orange = utils.get_highlight('Constant').fg,
        purple = utils.get_highlight('Statement').fg,
        cyan = utils.get_highlight('Special').fg,
        diag_warn = utils.get_highlight('DiagnosticWarn').fg,
        diag_error = utils.get_highlight('DiagnosticError').fg,
        diag_hint = utils.get_highlight('DiagnosticHint').fg,
        diag_info = utils.get_highlight('DiagnosticInfo').fg,
        git_del = utils.get_highlight('diffDeleted').fg,
        git_add = utils.get_highlight('diffAdded').fg,
        git_change = utils.get_highlight('diffChanged').fg,
      }
    end

    vim.o.laststatus = 3
    vim.o.showcmdloc = 'statusline'
    -- vim.o.spell = true
    require('heirline').setup {
      statusline = require('plugins.heirline.statusline').statusline,
      -- statusline = require 'plugins.heirline.example',
      winbar = require('plugins.heirline.statusline').winbar,
      tabline = require 'plugins.heirline.tabline',
      -- statuscolumn = require 'plugins.heirline.statuscolumn',
      opts = {
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
            filetype = { '^git.*', 'trouble', 'neo-tree' },
          }, args.buf)
        end,
        colors = setup_colors,
      },
    }
    -- vim.o.statuscolumn = require('heirline').eval_statuscolumn()

    vim.api.nvim_create_augroup('Heirline', { clear = true })

    -- vim.cmd [[au Heirline FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]

    -- vim.cmd("au BufWinEnter * if &bt != '' | setl stc= | endif")

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        utils.on_colorscheme(setup_colors)
      end,
      group = 'Heirline',
    })
  end,
  dependencies = {
    {
      'SmiteshP/nvim-navic',
      enabled = true,
      event = 'BufReadPost',
      config = function()
        require('nvim-navic').setup {
          -- icons = require("lspkind").symbol_map,
          separator = '',
          icons = {

            -- SymbolKind
            File = ' ',
            Module = ' ',
            Namespace = ' ',
            Package = ' ',
            Class = ' ',
            Method = ' ',
            Property = ' ',
            Field = ' ',
            Constructor = ' ',
            Enum = ' ',
            Interface = ' ',
            Function = ' ',
            Variable = ' ',
            Constant = ' ',
            String = ' ',
            Number = ' ',
            Boolean = ' ',
            Array = ' ',
            Object = ' ',
            Key = ' ',
            Null = ' ',
            EnumMember = ' ',
            Struct = ' ',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
            -- unique to CompletionIntemKind
            Text = ' ',
            Unit = ' ',
            Value = ' ',
            Keyword = ' ',
            Snippet = ' ',
            Color = ' ',
            Reference = ' ',
            Folder = ' ',

            -- Others
            Copilot = ' ',
          },
        }
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            ---@diagnostic disable-next-line: need-check-nil
            if not vim.tbl_contains({ 'copilot', 'ltex', 'tailwindcss', 'emmet_language_server' }, client.name) then
              require('nvim-navic').attach(client, bufnr)
            end
          end,
        })
      end,
    },
  },
}
