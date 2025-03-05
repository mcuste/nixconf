local function is_qf_or_ll_open()
  -- Check if quickfix or loclist window is open
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end
  return false
end

local tnext = function()
  local tr = require 'trouble'
  if tr.is_open() then
    tr.next()
  elseif is_qf_or_ll_open() then
    vim.cmd.cnext()
  end
end

local tprev = function()
  local tr = require 'trouble'
  if tr.is_open() then
    tr.prev()
  elseif is_qf_or_ll_open() then
    vim.cmd.cprev()
  end
end

local function map(lhs, rhs, desc)
  return {
    lhs,
    rhs,
    desc = desc,
  }
end

return {
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    event = 'VeryLazy',

    keys = {
      map(']q', tnext, 'Qf/Ll/Trouble Next'),
      map('[q', tprev, 'Qf/Ll/Trouble Prev'),
      map('<leader>ll', '<cmd>Trouble loclist toggle<cr>', 'Location List (Trouble)'),
      map('<leader>lq', '<cmd>Trouble qflist toggle<cr>', 'Quickfix List (Trouble)'),
      map('<leader>ld', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics (Trouble)'),
      map('<leader>lD', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics (Trouble)'),
      map('<leader>ls', '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols (Trouble)'),
      map('<leader>lg', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', 'LSP Definitions / references / ... (Trouble)'),
    },
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {},

    keys = {
      map('<leader>lt', '<cmd>Trouble todo<cr>', 'Todo List (Trouble)'),
    },
  },
}
