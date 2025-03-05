return {
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
      { '<leader>o', group = 'Open' },
      { '<leader>q', group = 'Persistence' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggles' },
    }
  end,
}
