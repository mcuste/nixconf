return {
  'stevearc/oil.nvim',

  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },

  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    view_options = { show_hidden = true },
    columns = { 'icon', 'permissions', 'size', 'mtime' },
    keymaps = {
      ['<C-s>'] = false,
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    },
  },

  keys = {
    { '<leader>oe', '<CMD>Oil<CR>', { desc = 'Oil' } },
  },
}
