local function config()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'
    local tailwind = require 'tailwindcss-colorizer-cmp'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local ls = luasnip
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
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
                return luasnip.jump(1)
            else
                return fallback()
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
            fields = { cmp.ItemField.Menu, cmp.ItemField.Abbr, cmp.ItemField.Kind },
            format = lspkind.cmp_format {
                mode = 'symbol_text',
                menu = {
                    -- TODO: fields should take priority before snip
                    buffer = '[BUF]',
                    nvim_lsp = '[LSP]',
                    luasnip = '[SNIP]',
                    nvim_lua = '[Lua]',
                    latex_symbols = '[LaTeX]',
                },
                before = tailwind.formatter,
            },
        },
        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'orgmode' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'crates' },
            { name = 'neorg' },
        },
        confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
        experimental = { ghost_text = true },
    }
    require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
    require('luasnip.loaders.from_vscode').lazy_load()
end
return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'rafamadriz/friendly-snippets',
        'hrsh7th/cmp-cmdline',
        'f3fora/cmp-spell',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim',
    },
    event = 'InsertEnter',
    config = config,
}
