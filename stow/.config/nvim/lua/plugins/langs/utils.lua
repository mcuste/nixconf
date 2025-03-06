return {
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang." },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "csv", "dot", "doxygen", "mermaid" },
    },
  },
}
