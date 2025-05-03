if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdscript",
        "gdshader",
        "glsl",
        "godot_resource",
        "wgsl",
        "wgsl_bevy",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
        gdshader_lsp = {},
      },
    },
  },
}
