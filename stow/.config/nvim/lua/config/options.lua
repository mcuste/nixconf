-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.o.undofile = true -- Enable persistent undo (see also `:h undodir`)
vim.o.undolevels = 1000 -- Keep longer undo history

vim.o.updatetime = 250 -- Decrease update time
vim.o.autowrite = true -- Autowrite the file if the focus moves away from the buffer
vim.o.swapfile = false -- Disable swapfiles
vim.o.backup = false -- Don't store backup while overwriting the file
vim.o.writebackup = false -- Don't store backup while overwriting the file

vim.o.mouse = "a" -- Enable mouse for all available modes

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  -- only set clipboard if not in ssh, to make sure the OSC 52
  -- integration works automatically. Requires Neovim >= 0.10.0
  vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)

-- Appearance
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.cursorline = true -- Highlight current line
vim.o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.termguicolors = true -- Enable gui colors
vim.o.laststatus = 3 -- Always show a single instance of status line for different panes
vim.o.guicursor = "n-v-c-i:block"

vim.o.ruler = false -- Don't show cursor position in command line
vim.o.showmode = false -- Don't show mode in command line
vim.o.wrap = false -- Display long lines as just one line

vim.o.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
vim.o.fillchars = "eob: " -- Don't show `~` outside of buffer

vim.o.scrolloff = 10 -- Min num of screen lines to keep above and below the cursor.
vim.o.sidescrolloff = 8 -- Min num of screen columns to keep to the left and to the right of the cursor

vim.opt.shortmess:append("WcC") -- Reduce command line messages
vim.o.splitkeep = "screen" -- Reduce scroll during window split

vim.opt.fillchars:append("vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣") -- Bold borders

vim.o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitution
vim.g.have_nerd_font = true -- Have a Nerd Font installed and selected in the terminal

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false -- disable folds by default

-- Editing
vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true -- Show search results while typing
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true -- Make indenting smart

vim.o.expandtab = true -- Use spaces instead of tab, cuz **** tabs
vim.o.tabstop = 4 -- Set space count for tab
vim.o.shiftwidth = 2 -- Set shiftwidth for indentation
vim.o.shiftround = true -- Set shiftround so the indentations are multiples of shiftwidth

vim.o.completeopt = "menu,menuone,noselect" -- Customize completions
vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode
vim.o.formatoptions = "jcroqlnt" -- tcqj

vim.o.spell = false -- Disable spelling by default (can toggle on during edit)
vim.opt.spelllang = { "en" } -- Set spell lang
