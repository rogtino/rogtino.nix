return {
    {
        'nvim-pack/nvim-spectre',
        config = true,
        keys = {
            { '<leader>sp', vim.cmd.Spectre, desc = 'open-spectre' },
            {
                '<leader>sc',
                function()
                    return vim.cmd.Spectre { 'path', vim.fn.expand '%:t:p' }
                end,
                desc = 'open-spectre-with-current-buffer',
            },
        },
    },
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
                python = true,
                hpp = true,
                cxx = true,
            },
            prompt_func_param_type = {
                go = true,
                cpp = true,
                python = true,
                c = true,
                java = true,
                hpp = true,
                cxx = true,
            },
        },
        keys = {
            {
                '<leader>rr',
                '<ESC>:Telescope refactoring refactors<CR>',
                desc = 'refactorings',
            },
        },
        config = true,
    },
    {
        'danymat/neogen',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = { snippet_engine = 'luasnip' },
        keys = {
            {
                '<leader>rf',
                ':Neogen func<cr>',
                desc = 'neogen function',
                mode = { 'n' },
            },
            {
                '<leader>rt',
                ':Neogen type<cr>',
                desc = 'neogen type',
                mode = { 'n' },
            },
            {
                '<leader>ri',
                ':Neogen file<cr>',
                desc = 'neogen file',
                mode = { 'n' },
            },
            {
                '<leader>rc',
                ':Neogen class<cr>',
                desc = 'neogen class',
                mode = { 'n' },
            },
        },
    },
    {
        'folke/flash.nvim',
        opts = { label = { uppercase = false } },
        keys = {
            'f',
            'F',
            't',
            'T',
            {
                's',
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
                mode = { 'n', 'x', 'o' },
            },
            {
                'S',
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
                mode = { 'n', 'o' },
            },
            -- {
            -- 	"R",
            -- 	mode = { "o", "x" },
            -- 	function()
            -- 		require("flash").treesitter_search()
            -- 	end,
            -- 	desc = "Treesitter Search",
            -- },
            -- {
            -- 	"r",
            -- 	function()
            -- 		require("flash").remote()
            -- 	end,
            -- 	desc = "Remote Flash",
            -- 	mode = "o",
            -- },
        },
    },
    {
        'numToStr/Comment.nvim',
        -- init = function()
        -- 	vim.keymap.set({ "n", "v", "o" }, "gc", "<nop>")
        -- 	vim.keymap.set({ "n", "v", "o" }, "gcc", "<nop>")
        -- end,
        opts = function(_, opts)
            opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
        end,
        -- event = "VeryLazy",
        keys = {
            {
                'gc',
                mode = {
                    'n',
                    'v',
                },
                desc = 'comment line',
            },
        },
        ft = { 'typescriptreact', 'javascriptreact' },
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            opts = function(_, opts)
                vim.g.skip_ts_context_commentstring_module = true
                opts.enable_autocmd = false
            end,
        },
    },
    {
        'cshuaimin/ssr.nvim',
        keys = {
            {
                '<leader>sr',
                function()
                    require('ssr').open()
                end,
                mode = { 'n', 'x' },
                desc = 'open-ssr',
            },
        },
        config = function()
            require('ssr').setup {
                min_width = 50,
                min_height = 5,
                keymaps = { close = 'q', next_match = 'n', prev_match = 'N', replace_all = '<leader><cr>' },
            }
        end,
    },
    {
        'kylechui/nvim-surround',
        opts = {
            keymaps = {
                insert = false,
                insert_line = false,
                normal = false,
                normal_cur = false,
                normal_line = false,
                normal_cur_line = false,
                visual = 'S',
                visual_line = false,
                delete = 'ds',
                change = 'cs',
                change_line = false,
            },
            surrounds = {
                ['F'] = {
                    add = function()
                        local config = require 'nvim-surround.config'
                        local result = config.get_input 'Enter the generic type name: '
                        if result then
                            return { { result .. '<' }, { '>' } }
                        end
                    end,
                },
            },
        },
        keys = {
            {
                'ds',
                desc = 'delete surround',
            },
            {
                'cs',
                desc = 'change surround',
            },
            { 'S', mode = 'x' },
        },
        -- event = "VeryLazy",
    },
    {
        'windwp/nvim-autopairs',
        opts = { check_ts = true, disable_filetype = { 'apl', 'TelescopePrompt' } },
        event = 'InsertEnter',
    },
    {
        'kawre/neotab.nvim',
        event = 'InsertEnter',
        opts = {
            -- configuration goes here
        },
    },
    {
        'chrisgrieser/nvim-spider',
        keys = {
            {
                'w',
                "<cmd>lua require('spider').motion('w')<CR>",
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-w',
            },
            {
                'e',
                "<cmd>lua require('spider').motion('e')<CR>",
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-e',
            },
            {
                'b',
                "<cmd>lua require('spider').motion('b')<CR>",
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-b',
            },
        },
    },
    {
        'axelvc/template-string.nvim',
        config = true,
        ft = { 'python', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
    },
    -- BUG: unable to use in nixos
    {
        'vhyrro/luarocks.nvim',
        priority = 1000,
        opts = {
            rocks = { 'magick' },
        },
    },
    {
        'nvim-neorg/neorg',
        cmd = 'Neorg',
        keys = {
            { '<leader>nn', ':Neorg workspace learn<CR>', desc = 'open workspace' },
            { '<leader>nj', ':Neorg journal ', desc = 'journal' },
            { '<leader>nt', ':Neorg journal today<CR>', desc = "today's journal" },
        },
        ft = 'norg',
        -- version = "v7.0.0",
        version = '*',
        -- build = ":Neorg sync-parsers",
        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.dirman'] = { config = { workspaces = { learn = '~/some-notes' } } },
                ['core.summary'] = {},
                ['core.ui.calendar'] = {},
                ['core.concealer'] = { config = { icon_preset = 'diamond' } },
                ['core.keybinds'] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.remap_event('norg', 'n', ',e', 'core.looking-glass.magnify-code-block')
                            -- keybinds.map("norg", "n", "q", vim.cmd.q)
                            keybinds.map('norg', 'n', ',ms', '<cmd>Neorg generate-workspace-summary<CR>')
                            keybinds.map('norg', 'n', '<localleader>tg', ':Neorg tangle current-file<CR>')
                            -- keybinds.map_to_mode("ui", {
                            -- 	n = {
                            -- 		{
                            -- 			"q",
                            -- 			vim.cmd.q,
                            -- 			opts = { desc = "[neorg] quit" },
                            -- 		},
                            -- 	},
                            -- }, {
                            -- 	silent = true,
                            -- 	noremap = true,
                            -- })
                        end,
                    },
                },
                ['core.completion'] = { config = { engine = 'nvim-cmp' } },
                ['core.journal'] = { config = { workspace = 'learn' } },
                ['core.presenter'] = { config = { zen_mode = 'zen-mode' } },
                ['core.export.markdown'] = {},
                ['core.export'] = {},
                ['core.integrations.telescope'] = {},
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neorg/neorg-telescope',
            'luarocks.nvim',
        },
    },
    {
        'nvim-orgmode/orgmode',
        dependencies = { { 'akinsho/org-bullets.nvim', config = true } },
        enabled = false,
        opts = { org_agenda_files = '~/orgfiles/**/*', org_default_notes_file = '~/orgfiles/refile.org' },
    },
}
