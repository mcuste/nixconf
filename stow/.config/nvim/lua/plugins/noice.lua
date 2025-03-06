return {
  "folke/noice.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>sn", false },
    { "<leader>snl", false },
    { "<leader>snh", false },
    { "<leader>sna", false },
    { "<leader>snd", false },
    { "<leader>snt", false },
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nH", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>nt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
  },
}
