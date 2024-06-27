return {
  -- {
  -- 	"ziontee113/deliberate.nvim",
  -- 	dependencies = {
  -- 		{
  -- 			"anuvyklack/hydra.nvim",
  -- 		},
  -- 	},
  -- 	lazy = false,
  -- 	config = function()
  -- 		local supported_filetypes = { "typescriptreact" }
  -- 		local augroup = vim.api.nvim_create_augroup("DeliberateEntryPoint", { clear = true })
  -- 		vim.api.nvim_create_autocmd({ "FileType" }, {
  -- 			pattern = supported_filetypes,
  -- 			group = augroup,
  -- 			callback = function()
  -- 				local bufnr = vim.api.nvim_get_current_buf()
  -- 				if vim.tbl_contains(supported_filetypes, vim.bo.ft) then
  -- 					vim.keymap.set("n", "<leader>d", function()
  -- 						vim.api.nvim_input("<Plug>DeliberateHydraEsc")
  -- 					end, { buffer = bufnr, desc = "toggle deliberate" })
  -- 					vim.keymap.set("i", "<Plug>DeliberateHydraEsc", "<Nop>", {})
  -- 				end
  -- 			end,
  -- 		})
  --
  -- 		require("deliberate.hydra")
  -- 	end,
  -- },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = 'background', -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
        virtualtext = '■',
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
      filetypes = {
        '*', -- Highlight all files, but customize some others.
        cmp_docs = { always_update = true },
        cmp_menu = { always_update = true },
      },
    },
    event = 'VeryLazy',
  },
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescriptreact', 'javascriptreact', 'javascript', 'typescript' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    -- config = true,
    opts = {
      on_attach = function()
        -- vim.lsp.inlay_hint.enable()
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
          -- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          -- includeInlayFunctionParameterTypeHints = true,
          -- includeInlayVariableTypeHints = true,
          -- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          -- includeInlayPropertyDeclarationTypeHints = true,
          -- includeInlayFunctionLikeReturnTypeHints = true,
          -- includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  {
    'ziontee113/icon-picker.nvim',
    opts = { disable_legacy_commands = true },
    cmd = 'IconPickerInsert',
    keys = {
      {

        '<leader>si',
        function()
          vim.cmd.IconPickerInsert 'nerd_font_v3'
        end,
        desc = 'search a icon',
        mode = 'n',
      },
    },
  },
  {
    'max397574/colortils.nvim',
    cmd = 'Colortils',
    config = true,
    keys = {
      {
        '<leader>pc',
        function()
          vim.cmd.Colortils()
        end,
        desc = 'Colortils',
      },
    },
  },
}
