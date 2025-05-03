if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.astro" },
  { import = "lazyvim.plugins.extras.lang.vue" },

  { import = "lazyvim.plugins.extras.lang.svelte" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          keys = {
            { "<leader>co", false },
            { "<leader>lo", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
        },
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          keys = {
            { "<leader>co", false },
            { "<leader>cM", false },
            { "<leader>cu", false },
            { "<leader>cD", false },
            { "<leader>cV", false },

            { "<leader>lo", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
            { "<leader>lM", LazyVim.lsp.action["source.addMissingImports.ts"], desc = "Add missing imports" },
            { "<leader>lu", LazyVim.lsp.action["source.removeUnused.ts"], desc = "Remove unused imports" },
            { "<leader>lD", LazyVim.lsp.action["source.fixAll.ts"], desc = "Fix all diagnostics" },
            {
              "<leader>lV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "graphql", "scss" } },
  },
}
