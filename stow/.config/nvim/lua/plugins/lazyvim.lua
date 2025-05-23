if vim.g.vscode then
  return {}
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = false, -- lazyvim.config.keymaps - don't need it
        options = true, -- lazyvim.config.options
      },
    },
    keys = {
      { "<leader>lzz", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
  },
}
