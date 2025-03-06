return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bash", "fish" } },
  },

  -- opts = { ensure_installed = { "shellcheck", "shellharden", "shfmt" } },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "shellharden", "shfmt" } },
  },

  -- bash = { "shellcheck", "shellharden", "shfmt" },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { bash = { "shellharden", "shfmt" } } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { servers = { bashls = { settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command)" } } } } },
  },
}
