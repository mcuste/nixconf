if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },

  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "alejandra" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          formatting = { command = { "alejandra" } },
          nixpkgs = {
            expr = 'import (builtins.getFlake "/home/' .. os.getenv("USER") .. '/nixconf").inputs.nixpkgs { }',
          },
          options = {
            nixos = {
              -- stylua: ignore
              expr = '(builtins.getFlake "/home/' .. os.getenv("USER") .. '/nixconf").nixosConfigurations.nixos.options',
            },
            home_manager = {
              -- stylua: ignore
              expr = '(builtins.getFlake "/home/' .. os.getenv("USER") .. '/nixconf").homeConfigurations."' .. os.getenv("USER") .. '@fedora".options',
            },
          },
        },
      },
    },
  },
}
