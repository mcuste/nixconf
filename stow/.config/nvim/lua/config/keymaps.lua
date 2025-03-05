-- Move by visible lines
vim.keymap.set({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add empty line below and above without moving (dot repeatable version available on mini.basic)
vim.keymap.set('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.keymap.set('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Reselect latest changed, put, or yanked text
vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Visually select changed text',
})

-- Search inside visually highlighted text. Use `silent = false` for it to make effect immediately.
vim.keymap.set('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
vim.keymap.set('n', '<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' })
vim.keymap.set({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

-- Window navigation
vim.keymap.set('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
vim.keymap.set('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
vim.keymap.set('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
vim.keymap.set('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- Window resize (respecting `v:count`)
vim.keymap.set('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Decrease window width',
})
vim.keymap.set('n', '<C-Down>', '"<Cmd>resize -" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Decrease window height',
})
vim.keymap.set('n', '<C-Up>', '"<Cmd>resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Increase window height',
})
vim.keymap.set('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Increase window width',
})

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set({ 'n', 'i' }, '<esc>', '<cmd>nohlsearch<cr><esc>')

-- Replace word under cursor
vim.keymap.set('n', 'gR', ':%s/<C-r><C-w>//gc<Left><Left><Left>', { desc = 'Replace word under cursor' })

-- Delete word without saving to register
vim.keymap.set('n', '<leader>ed', 'viw"_d', { desc = 'Delete word w/o register' })
vim.keymap.set('v', '<leader>ed', '"_d', { desc = 'Delete w/o register' })

-- Move to the beginning or end of line with H and L
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move beginning of line' })
vim.keymap.set('n', 'L', '$', { desc = 'Move end of line' })
vim.keymap.set('v', 'L', 'g_', { desc = 'Move end of line' })

-- Center cursor after jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after jump' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after jump' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center cursor after jump' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center cursor after jump' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Toggles
local toggle = function(lhs, rhs, desc)
  vim.keymap.set('n', '<leader>u' .. lhs, rhs, { desc = desc })
end

toggle('l', '<Cmd>setlocal cursorline! cursorline?<CR>', "Toggle 'cursorline'")
toggle('o', '<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>', "Toggle 'cursorcolumn'")
toggle('i', '<Cmd>setlocal ignorecase! ignorecase?<CR>', "Toggle 'ignorecase'")
toggle('s', '<Cmd>setlocal spell! spell?<CR>', "Toggle 'spell'")
toggle('w', '<Cmd>setlocal wrap! wrap?<CR>', "Toggle 'wrap'")
toggle('c', function()
  local winnr = vim.api.nvim_get_current_win()
  local conceallevel = vim.api.nvim_win_get_option(winnr, 'conceallevel')
  local newconceallevel = math.fmod(conceallevel + 1, 4)
  vim.opt.conceallevel = newconceallevel
end, "Toggle 'conceallevel'")
-- some other toggles are added via snacks.nvim

-- TODO: Implement mini.bracketed for the following only
-- conflict   = { suffix = 'x', options = {} },
