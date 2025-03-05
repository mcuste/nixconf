return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    opts = {
      flavour = 'mocha',
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      default_integrations = true,
      integrations = {
        blink_cmp = true,
        -- TODO: bufferline
        diffview = true, -- TODO
        fidget = true, -- TODO special config
        grug_far = true, -- TODO
        mason = true, -- TODO
        neotest = true,
        snacks = {
          enabled = true,
          indent_scope_color = 'lavender',
        },
        lsp_trouble = true,
        which_key = true,
      },
    },

    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'catppuccin',
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '│', right = '│' },
      },
    },
  },

  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = {
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},

    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },

    config = function()
      local wk = require 'which-key'
      wk.add {
        { '<BS>', desc = 'Decrement Selection', mode = 'x' },
        { '<c-space>', desc = 'Increment Selection', mode = { 'x', 'n' } },
        { '<leader>\\', group = 'Surround' },
        { '<leader>b', group = 'Buffer' },
        { '<leader>c', group = 'Copilot' },
        { '<leader>e', group = 'Edit' },
        { '<leader>ew', group = 'Swap Arg/Func' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>l', group = 'LSP/Lists' },
        { '<leader>n', group = 'Notifications' },
        { '<leader>q', group = 'Persistence' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Test' },
        { '<leader>u', group = 'Toggles' },
      }
    end,
  },
}
