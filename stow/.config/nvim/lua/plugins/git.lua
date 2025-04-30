return {
  { "lewis6991/gitsigns.nvim", enabled = false },

  -- Import mini.diff from extras and override keymaps
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  {
    "echasnovski/mini.diff",
    opts = {
      mappings = {
        apply = "<leader>ga", -- visual
        reset = "<leader>gA", -- visual
        textobject = "<leader>gh", -- textobject
      },
    },
  },

  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = "  <date> • <author> • <summary>",
      date_format = "%Y-%m-%d",
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Blame" },
    },
  },

  {
    "wintermute-cell/gitignore.nvim",
    event = "VeryLazy",
    config = function()
      require("gitignore")
    end,
    keys = {
      {
        "<leader>gi",
        function()
          require("gitignore").generate({})
        end,
        desc = "Gitignore",
      },
    },
  },

  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
}
