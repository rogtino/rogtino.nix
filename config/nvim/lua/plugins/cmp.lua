local function config()
  -- local has_words_before = function()
  --   unpack = unpack or table.unpack
  --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  -- end
  local cmp = require 'cmp'
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  local lspkind = require 'lspkind'
  local luasnip = require 'luasnip'
  local tailwind = require 'tailwindcss-colorizer-cmp'
  local ls = luasnip
  --- generate source for specific filetype
  ---@param ft_name string | table
  ---@param extra_table table
  local function ext_source(ft_name, extra_table)
    local tmp = {
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'calc' },
    }
    for _, v in ipairs(extra_table) do
      table.insert(tmp, v)
    end
    cmp.setup.filetype(ft_name, {
      sources = tmp,
    })
  end

  local mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<A-n>'] = cmp.mapping(function(fallback)
      if ls.choice_active() then
        ls.change_choice(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<A-p>'] = cmp.mapping(function(fallback)
      if ls.choice_active() then
        ls.change_choice(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm {
            select = true,
          }
        end
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        return luasnip.jump(-1)
      else
        return fallback()
      end
    end, { 'i', 's' }),
  }
  local border = {
    { '╭', 'FoldColumn' },
    { '─', 'FoldColumn' },
    { '╮', 'FoldColumn' },
    { '│', 'FoldColumn' },
    { '╯', 'FoldColumn' },
    { '─', 'FoldColumn' },
    { '╰', 'FoldColumn' },
    { '│', 'FoldColumn' },
  }
  -- local ts_utils = require("nvim-treesitter.ts_utils")
  luasnip.config.setup {
    update_events = 'TextChanged,TextChangedI',
    store_selection_keys = '<TAB>',
    snip_env = {
      s = ls.s,
      sn = ls.sn,
      t = ls.t,
      i = ls.i,
      f = function(func, argnodes, ...)
        return ls.f(function(args, imm_parent, user_args)
          return func(args, imm_parent.snippet, user_args)
        end, argnodes, ...)
      end,
      c = function(pos, nodes, opts)
        opts = (opts or {})
        opts.restore_cursor = true
        return ls.c(pos, nodes, opts)
      end,
      d = function(pos, func, argnodes, ...)
        return ls.d(pos, function(args, imm_parent, old_state, ...)
          return func(args, imm_parent.snippet, old_state, ...)
        end, argnodes, ...)
      end,
      l = function()
        return require('luasnip.extras').lambda()
      end,
      isn = require('luasnip.nodes.snippet').ISN,
      dl = function()
        return require('luasnip.extras').dynamic_lambda
      end,
      rep = require('luasnip.extras').rep,
      r = ls.restore_node,
      p = require('luasnip.extras').partial,
      types = require 'luasnip.util.types',
      events = require 'luasnip.util.events',
      util = require 'luasnip.util.util',
      fmt = require('luasnip.extras.fmt').fmt,
      fmta = require('luasnip.extras.fmt').fmta,
      ls = ls,
      ins_generate = function(nodes)
        return setmetatable((nodes or {}), {
          __index = function(table, key)
            local indx = tonumber(key)
            if indx then
              local val = ls.i(indx)
              rawset(table, key, val)
              return val
            else
              return nil
            end
          end,
        })
      end,
      parse = ls.parser.parse_snippet,
      n = require('luasnip.extras').nonempty,
      m = require('luasnip.extras').match,
      ai = require 'luasnip.nodes.absolute_indexer',
    },
  }
  -- TODO:make this work
  -- cmp.event:on("confirm_done", function(evt)
  -- 	local name = ts_utils.get_node_at_cursor():type()
  -- 	if (name ~= "named_imports") and (name ~= "source_file") then
  -- 		return cmp_autopairs.on_confirm_done()(evt)
  -- 	else
  -- 		return nil
  -- 	end
  -- end)
  -- If you want insert `(` after select function or method item
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  cmp.setup {
    snippet = {
      expand = function(args)
        return luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = { border = border, scrollbar = true },
      documentation = { border = border },
    },
    mapping = mapping,
    formatting = {
      expandable_indicator = true,
      fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
      format = lspkind.cmp_format {
        mode = 'symbol',
        maxwidth = 38,
        menu = {
          buffer = '[Buf]',
          nvim_lsp = '[Lsp]',
          luasnip = '[Snip]',
          nvim_lua = '[Lua]',
          latex_symbols = '[LaTeX]',
          orgmode = '[Org]',
          ['vim-dadbod-completion'] = '[DB]',
          calc = '[Calc]',
          conventionalcommits = '[CC]',
          emoji = '[Emoji]',
          nerdfont = '[Nerd]',
          ['cmp-tw2css'] = '[Twcss]',
          npm = '[Npm]',
          treesitter = '[Tree]',
        },
        before = tailwind.formatter,
      },
    },
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'path' },
    }, {
      { name = 'buffer' },
      { name = 'calc' },
    }),
    confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
    experimental = { ghost_text = true },
  }
  -- BUG:https://github.com/davidsierradz/cmp-conventionalcommits/issues/5
  ext_source('NeogitCommitMessage', {
    { name = 'conventionalcommits' },
    { name = 'emoji' },
    { name = 'nerdfont' },
  })
  ext_source('lua', {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
  })
  ext_source('scheme', {
    { name = 'treesitter' },
  })
  ext_source({ 'html', 'css' }, {
    { name = 'cmp-tw2css' },
    { name = 'nvim_lsp' },
  })
  ext_source('toml', {
    { name = 'crates' },
    { name = 'nvim_lsp' },
  })
  ext_source('neorg', {
    { name = 'neorg' },
    { name = 'emoji' },
    { name = 'nerdfont' },
  })
  ext_source('org', {
    { name = 'orgmode' },
    { name = 'emoji' },
    { name = 'nerdfont' },
  })
  ext_source('sql', {
    { name = 'vim-dadbod-completion' },
  })
  ext_source('json', {
    { name = 'npm' },
  })
  require('luasnip.loaders.from_lua').lazy_load {
    paths = { vim.fn.stdpath 'config' .. '/snippets' },
    default_priority = 2000,
  }
  require('luasnip.loaders.from_vscode').lazy_load()
end
return {
  {
    'hrsh7th/nvim-cmp',

    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'rafamadriz/friendly-snippets',
      -- 'f3fora/cmp-spell',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-calc',
    },
    event = { 'InsertEnter', 'LspAttach' },
    config = config,
  },
  { 'davidsierradz/cmp-conventionalcommits', ft = 'NeogitCommitMessage' },
  {
    ft = 'NeogitCommitMessage',
    'hrsh7th/cmp-emoji',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
  },
  {
    'chrisgrieser/cmp-nerdfont',
    ft = { 'neorg', 'org', 'NeogitCommitMessage' },
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
  },
  {
    'jcha0713/cmp-tw2css',
    ft = { 'html', 'css' },
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
  },
  {
    'David-Kunz/cmp-npm',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    event = 'BufRead package.json',
    opts = {},
  },
  {
    'ray-x/cmp-treesitter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    ft = { 'lua', 'scheme' },
  },
}
