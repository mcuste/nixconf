return {
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.sql" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dot", "doxygen", "mermaid" },
    },
  },
}
