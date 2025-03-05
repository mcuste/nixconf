return {
  { 'nmac427/guess-indent.nvim', opts = {} },
  { 'folke/ts-comments.nvim', event = 'VeryLazy', opts = {} }, -- comments for JS stuff
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

  { 'echasnovski/mini.ai', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.move', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.bufremove', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.splitjoin', event = 'VeryLazy', opts = { mappings = { toggle = '<leader>ej' } } },

  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    'echasnovski/mini.operators',
    event = 'VeryLazy',
    opts = {
      evaluate = { prefix = '<leader>e=' },
      exchange = { prefix = '<leader>ex' },
      multiply = { prefix = '<leader>em' },
      replace = { prefix = '<leader>er' },
      sort = { prefix = '<leader>es' },
    },
  },

  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = '\\a', -- Add surrounding in Normal and Visual modes
        delete = '\\d', -- Delete surrounding
        find = '\\f', -- Find surrounding (to the right)
        find_left = '\\F', -- Find surrounding (to the left)
        highlight = '\\h', -- Highlight surrounding
        replace = '\\r', -- Replace surrounding
        update_n_lines = '\\n', -- Update `n_lines`
      },
    },
  },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
