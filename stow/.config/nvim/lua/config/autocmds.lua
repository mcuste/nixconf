-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Fix terraform and hcl comment string.",
  group = vim.api.nvim_create_augroup("fix-tf-commentstring", { clear = true }),
  pattern = { "terraform", "hcl" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
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
