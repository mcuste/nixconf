return {
  'danymat/neogen',
  cmd = 'Neogen',

  opts = {
    snippet_engine = 'luasnip',
  },

  keys = {
    {
      '<leader>la',
      function()
        require('neogen').generate()
      end,
      desc = 'Generate Annotations (Neogen)',
    },
  },
}
