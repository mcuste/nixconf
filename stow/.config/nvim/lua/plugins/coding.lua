return {
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(keys, {
        { "<leader>cl", false },
        { "<leader>ca", false},
        { "<leader>cc", false},
        { "<leader>cC", false},
        { "<leader>cR", false},
        { "<leader>cr", false},
        { "<leader>cA", false},

        { "<leader>lz", "", desc = "+code", mode = { "n" } },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
        { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
        { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
        { "<leader>lR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
        { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
        
        -- Tools
        { "<leader>lz", "", desc = "+tools", mode = { "n" } },
        { "<leader>lzl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
      { "<leader>lzm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", false },
      { "<leader>xX", false },
      { "<leader>cs", false },
      { "<leader>cS", false },
      { "<leader>xL", false },
      { "<leader>xQ", false },
      { "<leader>ld", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>lD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>lL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>lQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  {
    "danymat/neogen",
    keys = {
      { "<leader>cn", false },
      {
        "<leader>ln",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Annotations (Neogen)",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cF", false },
      {
        "<leader>lF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
  },
}
