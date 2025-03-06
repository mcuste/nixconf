return {
  { "nmac427/guess-indent.nvim", opts = {} },
  -- mini.ai already added by lazy
  { import = "lazyvim.plugins.extras.editor.mini-move" },
  { "echasnovski/mini.bufremove", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.splitjoin", event = "VeryLazy", opts = { mappings = { toggle = "<leader>ej" } } },
  -- mini.comment already added by lazy
  -- persistence already added by lazy

  {
    "echasnovski/mini.operators",
    event = "VeryLazy",
    opts = {
      evaluate = { prefix = "<leader>e=" },
      exchange = { prefix = "<leader>ex" },
      multiply = { prefix = "<leader>em" },
      replace = { prefix = "<leader>er" },
      sort = { prefix = "<leader>eS" },
    },
  },

  -- Import mini.surround from extras and override keymaps
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "<leader>ea",
        delete = "<leader>ed",
        find = "<leader>ef",
        find_left = "<leader>eF",
        highlight = "<leader>eh",
        replace = "<leader>er",
        update_n_lines = "<leader>en",
      },
    },
  },
}
