-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Move by visible lines
vim.keymap.set({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add empty line below and above without moving (dot repeatable version available on mini.basic)
vim.keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.keymap.set("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Reselect latest changed, put, or yanked text
vim.keymap.set("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
  expr = true,
  replace_keycodes = false,
  desc = "Visually select changed text",
})

-- Search inside visually highlighted text. Use `silent = false` for it to make effect immediately.
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
vim.keymap.set("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
vim.keymap.set({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

-- Window navigation -- Enable if not using tmux navigator
-- vim.keymap.set("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
-- vim.keymap.set("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
-- vim.keymap.set("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
-- vim.keymap.set("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

-- Window resize (respecting `v:count`)
vim.keymap.set("n", "<C-Left>", '"<Cmd>vertical resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Decrease window width",
})
vim.keymap.set("n", "<C-Down>", '"<Cmd>resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Decrease window height",
})
vim.keymap.set("n", "<C-Up>", '"<Cmd>resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Increase window height",
})
vim.keymap.set("n", "<C-Right>", '"<Cmd>vertical resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = "Increase window width",
})

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>nohlsearch<cr><esc>")

-- Replace word under cursor
vim.keymap.set("n", "gR", ":%s/<C-r><C-w>//gc<Left><Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("v", "gR", '"hy:%s/<C-r>h//gc<Left><Left><Left>', { desc = "Replace visually selected text" })

-- Paste/Delete word without saving to register
vim.keymap.set("v", "gp", '"_dP', { desc = "Paste w/o saving replaced text to register" })
vim.keymap.set("n", "gX", 'viw"_d', { desc = "Delete word w/o register" })
vim.keymap.set("v", "gX", '"_d', { desc = "Delete w/o register" })

-- Move to the beginning or end of line with H and L
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Move beginning of line" })
vim.keymap.set("n", "L", "$", { desc = "Move end of line" })
vim.keymap.set("v", "L", "g_", { desc = "Move end of line" })

-- Center cursor after jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after jump" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after jump" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center cursor after jump" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center cursor after jump" })

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
if not vim.g.vscode then
  if vim.fn.has("nvim-0.11") == 0 then
    vim.keymap.set("s", "<Tab>", function()
      return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
    end, { expr = true, desc = "Jump Next" })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
    end, { expr = true, desc = "Jump Previous" })
  end
end

-- Diagnostic
if not vim.g.vscode then
  local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go({ severity = severity })
    end
  end
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
  vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
  vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
end

-- Finer conceallevel control
-- toggle("c", function()
--   local winnr = vim.api.nvim_get_current_win()
--   local conceallevel = vim.api.nvim_win_get_option(winnr, "conceallevel")
--   local newconceallevel = math.fmod(conceallevel + 1, 4)
--   vim.opt.conceallevel = newconceallevel
-- end, "Toggle 'conceallevel'")
