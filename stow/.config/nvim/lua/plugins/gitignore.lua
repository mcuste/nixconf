return {
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
}
