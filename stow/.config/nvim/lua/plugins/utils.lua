return {
  { 'nmac427/guess-indent.nvim', opts = {} },
  { 'MunifTanjim/nui.nvim', lazy = true },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {
      disable_filetype = { 'snacks_picker_list', 'snacks_picker_input' },
    },
  },

  -- TODO: zellij
}
