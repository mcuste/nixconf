-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- TODO: cleanup?

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text.",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Start terminal on insert mode.",
  group = vim.api.nvim_create_augroup("insert-on-term-open", { clear = true }),
  pattern = { "term://*" },
  callback = vim.schedule_wrap(function(data)
    -- Try to start terminal mode only if target terminal is current
    if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == "terminal") then
      return
    end
    vim.cmd("startinsert")
  end),
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Reload the buffer if it has changed.",
  group = vim.api.nvim_create_augroup("reload-buffer", { clear = true }),
  command = "checktime",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized.",
  group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = "Go to last loc when opening a buffer.",
  group = vim.api.nvim_create_augroup("lastloc-on-open", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Wrap and check for spell in text file types.",
  group = vim.api.nvim_create_augroup("wrap-spell-on-textfiles", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Close listed filetypes with `q`.",
  group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
  pattern = { "help", "man", "qf", "loclist" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Fix terraform and hcl comment string.",
  group = vim.api.nvim_create_augroup("fix-tf-commentstring", { clear = true }),
  pattern = { "terraform", "hcl" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
})
