return {
  {
    'NoahTheDuke/vim-just',
    ft = { 'just' },
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },
  -- { 'kaarmu/typst.vim', ft = 'typst' },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    opts = {
      dependencies_bin = {
        ['typst-preview'] = 'typst-preview',
        ['websocat'] = nil,
      },
    },
  },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  { 'gennaro-tedesco/nvim-jqx', ft = { 'json', 'yaml' } },
  -- { "elkowar/yuck.vim", ft = "yuck" },
  {
    'mmarchini/bpftrace.vim',
    ft = 'bpftrace',
  },
  {
    'Saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local crates = require 'crates'

      vim.keymap.set(
        'n',
        '<leader>cv',
        crates.show_versions_popup,
        { silent = true, buffer = 0, desc = 'show_versions_popup' }
      )
      vim.keymap.set(
        'n',
        '<leader>cf',
        crates.show_features_popup,
        { silent = true, buffer = 0, desc = 'show_features_popup' }
      )
      vim.keymap.set(
        'n',
        '<leader>cd',
        crates.show_dependencies_popup,
        { silent = true, buffer = 0, desc = 'show_dependencies_popup' }
      )
      vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, buffer = 0, desc = 'update_crate' })
      vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, buffer = 0, desc = 'update_crates' })
      vim.keymap.set(
        'n',
        '<leader>ca',
        crates.update_all_crates,
        { silent = true, buffer = 0, desc = 'update_all_crates' }
      )
      vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, buffer = 0, desc = 'upgrade_crate' })
      vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, buffer = 0, desc = 'upgrade_crates' })
      vim.keymap.set(
        'n',
        '<leader>cA',
        crates.upgrade_all_crates,
        { silent = true, buffer = 0, desc = 'upgrade_all_crates' }
      )
      vim.keymap.set(
        'n',
        '<leader>cx',
        crates.expand_plain_crate_to_inline_table,
        { silent = true, buffer = 0, desc = 'expand_plain_crate_to_inline_table' }
      )
      vim.keymap.set(
        'n',
        '<leader>cX',
        crates.extract_crate_into_table,
        { silent = true, buffer = 0, desc = 'extract_crate_into_table' }
      )
      vim.keymap.set('n', '<leader>cH', crates.open_homepage, { silent = true, buffer = 0, desc = 'open_homepage' })
      vim.keymap.set('n', '<leader>cR', crates.open_repository, { silent = true, buffer = 0, desc = 'open_repository' })
      vim.keymap.set(
        'n',
        '<leader>cD',
        crates.open_documentation,
        { silent = true, buffer = 0, desc = 'open_documentation' }
      )
      vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { silent = true, buffer = 0, desc = 'open_crates_io' })
      crates.setup {}
    end,
  },
  {
    'davidmh/mdx.nvim',
    config = true,
    ft = 'mdx',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
