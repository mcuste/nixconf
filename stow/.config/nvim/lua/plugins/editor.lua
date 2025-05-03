return {
  { "nmac427/guess-indent.nvim", opts = {} },
  -- mini.ai already added by lazy
  { import = "lazyvim.plugins.extras.editor.mini-move" },
  { "echasnovski/mini.bufremove", event = "VeryLazy", opts = {} },
  -- mini.comment already added by lazy
  -- persistence already added by lazy
  { import = "lazyvim.plugins.extras.coding.mini-surround" },

  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", false },
      {
        "<leader>lzr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
