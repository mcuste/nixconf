local function is_qf_or_ll_open()
  -- Check if quickfix or loclist window is open
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then return true end
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

return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  event = 'VeryLazy',
  keys = {
    {
      ']q', tnext, desc = 'Qf/Ll/Trouble Next'
    },

    {
      '[q', tprev, desc = 'Qf/Ll/Trouble Prev'
    },

    {
      '<leader>ll',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },

    {
      '<leader>lq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },

    {
      '<leader>ld',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },

    {
      '<leader>lD',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },

    {
      '<leader>ls',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },

    {
      '<leader>lg',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
  },
}
