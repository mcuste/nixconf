return {
  {
    "stevearc/oil.nvim",

    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },

    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      view_options = { show_hidden = true },
      columns = { "icon", "permissions", "size", "mtime" },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      },
    },

    keys = {
      { "<leader>fe", "<CMD>Oil<CR>", { desc = "Oil" } },
    },

    -- TODO: check if oil file rename triggers LSP rename
  },

  {
    "otavioschwanck/arrow.nvim",
    dependencies = { { "echasnovski/mini.icons" } },
    event = "VeryLazy",

    opts = {
      show_icons = true,
      leader_key = "m",
      buffer_leader_key = "-",
      index_keys = "asdfgqwert",
    },
  },

  -- override
  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- override
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
  },
}
