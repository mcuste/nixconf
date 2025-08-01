if vim.g.vscode then
  return {}
end

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

return {
  { import = "lazyvim.plugins.extras.lang.cmake" },

  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>ch", false },
            { "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },

            { "<leader>ll", "", desc = "+lang", mode = { "n", "v" } },
          },
        },
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.rust" },
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>lla", function() -- language specific keymaps on <leader>ll
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.go" },

  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          keys = {
            { "<leader>co", false },
            {
              "<leader>lo",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        ruff_lsp = {
          keys = {
            { "<leader>co", false },
            {
              "<leader>lo",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
    },
  },
  { "linux-cultist/venv-selector.nvim", enabled = false },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "htmldjango",
        "http",
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
