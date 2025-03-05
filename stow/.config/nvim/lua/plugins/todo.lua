return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {},

  keys = {
    {
      '<leader>lt',
      '<cmd>Trouble todo<cr>',
      desc = 'Todo List (Trouble)',
    },
  },
}
