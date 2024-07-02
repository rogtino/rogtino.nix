local function config()
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- capabilities.offsetEncoding = { "utf-16" }
  local servers = {
    astro = {},
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          completion = { callSnippet = 'Replace' },
          hint = { enable = true },
          workspace = {
            -- diagnostics = {
            --   globals = { 'vim' },
            -- },
            maxPreload = 100000,
            preloadFileSize = 10000,
            checkThirdParty = false,
          },
        },
      },
    },
    -- ruff_lsp = {},
    pyright = {},
    html = {},
    taplo = {},
    prismals = {},
    emmet_language_server = {},
    gopls = {},
    -- selene = {},
    cssls = {
      settings = {
        css = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
        scss = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
        less = { validate = true, lint = {
          unknownAtRules = 'ignore',
        } },
      },
    },
    asm_lsp = {},
    marksman = {},
    -- BUG:no idea why this triggers an error in :LspInfo
    -- mdx_analyzer = {
    -- 	filetypes = "mdx",
    -- },
    clangd = {
      on_attach = function()
        require('clangd_extensions.inlay_hints').setup_autocmd()
        require('clangd_extensions.inlay_hints').set_inlay_hints()
      end,
    },
    tailwindcss = {},
    bashls = {},
    nil_ls = {},
    cmake = {},
    solidity_ls = {},
    phpactor = {},
    qmlls = {},
    -- autotools_ls = {},
    typst_lsp = { settings = { exportPdf = 'onSave' } },
  }
  for client, setup in pairs(servers) do
    setup = vim.tbl_deep_extend('force', {
      -- capabilities = capabilities,
      on_attach = function(cli)
        if cli.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable()
        end
      end,
    }, setup)
    require('lspconfig')[client].setup(setup)
  end
end
return {
  {
    'neovim/nvim-lspconfig',
    config = config,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true, ft = 'lua' }, -- optional `vim.uv` typings
      {
        'mfussenegger/nvim-lint',
        config = function()
          require('lint')['linters_by_ft'] = {
            -- markdown = { 'vale' },
            cpp = { 'clangtidy' },
            python = { 'ruff' },
            -- lua = { 'selene' },
            typescriptreact = { 'biomejs' },
            javascript = { 'biomejs' },
            typescript = { 'biomejs' },
            javascriptreact = { 'biomejs' },
          }
        end,
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    ft = 'rust',
    version = '^4',
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client)
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable()
            end
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              rustfmt = {
                extraArgs = { '+nightly' },
              },
            },
          },
        },
      }
    end,
    keys = {
      {
        '<localleader>r',
        function()
          vim.cmd.RustLsp 'runnables'
        end,
        ft = 'rust',
        desc = 'runnables',
      },
      {
        '<localleader>e',
        function()
          vim.cmd.RustLsp 'expandMacro'
        end,
        ft = 'rust',
        desc = 'expand-macro',
      },
    },
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
      {
        '<leader>sd',
        '<cmd>Trouble diagnostics preview focus=true<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>sb',
        '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      -- {
      --   '<leader>ls',
      --   '<cmd>Trouble symbols toggle focus=true<cr>',
      --   desc = 'Symbols (Trouble)',
      -- },
      -- {
      --   '<leader>lf',
      --   '<cmd>Trouble lsp toggle focus=true win.position=left<cr>',
      --   desc = 'LSP finder (Trouble)',
      -- },
      -- {
      -- 	"<leader>lp",
      -- 	"<cmd>Trouble lsp toggle_preview focus=true win.position=left<cr>",
      -- 	desc = "LSP Definitions / references / ... (Trouble)",
      -- },
      -- {
      -- 	"<leader>xL",
      -- 	"<cmd>Trouble loclist toggle<cr>",
      -- 	desc = "Location List (Trouble)",
      -- },
      -- {
      -- 	"<leader>xQ",
      -- 	"<cmd>Trouble qflist toggle<cr>",
      -- 	desc = "Quickfix List (Trouble)",
      -- },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
  {
    url = 'https://git.sr.ht/~p00f/clangd_extensions.nvim',
  },
  -- BUG: polute input
  -- {
  -- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  -- 	config = true,
  -- },
}
