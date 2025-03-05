return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  opts = {
    flavour = 'mocha',
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    default_integrations = true,
    integrations = {
      -- TODO: check integrations
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      mini = {
        enabled = true,
        indentscope_color = 'lavender',
      },
    },
  },

  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
