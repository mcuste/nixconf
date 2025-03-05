return {
  {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    opts = {
      mappings = {
        apply = '<leader>ga', -- visual
        reset = '<leader>gA', -- visual
        textobject = '<leader>gh', -- textobject
      },
    },
  },

  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = true,
      message_template = '  <date> • <author> • <summary>',
      date_format = '%Y-%m-%d',
    },
    keys = {
      { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = 'Toggle Blame' },
    },
  },

  {
    'wintermute-cell/gitignore.nvim',
    event = 'VeryLazy',
    config = function()
      require 'gitignore'
    end,
    keys = {
      {
        '<leader>gi',
        function()
          require('gitignore').generate()
        end,
        desc = 'Gitignore',
      },
    },
  },
}
