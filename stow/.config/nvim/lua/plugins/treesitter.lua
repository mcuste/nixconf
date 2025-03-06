return {
  -- Add treesitter-context
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },

  -- Add treesitter comment strings
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    opts = { enable_autocmd = false },
  },

  -- TS syntax highlight for Nix HM strings
  {
    "calops/hmts.nvim",
    event = "VeryLazy",
    version = "*",
  },
}
