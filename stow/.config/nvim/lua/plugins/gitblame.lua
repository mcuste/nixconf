return {
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
}

-- TODO: diffview
