return {
  { 'echasnovski/mini.ai', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.move', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.bufremove', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.splitjoin', event = 'VeryLazy', opts = { mappings = { toggle = '<leader>ej' } } },

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
}
