return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup({
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = "mcc",
        ---Block-comment toggle keymap
        block = "mbc",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "mc",
        ---Block-comment keymap
        block = "mb",
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = "mcO",
        ---Add comment on the line below
        below = "mco",
        ---Add comment at the end of line
        eol = "mcA",
      },
    })
  end,
}
