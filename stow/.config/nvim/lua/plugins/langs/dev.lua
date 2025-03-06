vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

return {
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.zig" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.ocaml" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "htmldjango",
        "http",
        "ocaml_interface",
        "ocamllex",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "clang-format" } },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { cpp = { "clang-format" } } },
  },
}
