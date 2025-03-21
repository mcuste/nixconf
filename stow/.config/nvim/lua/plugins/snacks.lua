-- Disable default picker keybinds and remap them with custom implementation for git root
return {
  {
    "folke/snacks.nvim",

    opts = {
      explorer = { enabled = false },
      scroll = { enabled = false },
      debug = { enabled = true },
    },

    -- stylua: ignore
    keys = {
      { "<leader>,", false }, -- buffers
      { "<leader>/", false }, -- grep
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader><space>", false }, -- false
      { "<leader>n", false }, -- notification history
      -- find
      { "<leader>fb", false }, -- Buffers
      { "<leader>fB", false }, -- Buffers (all)
      { "<leader>fc", false }, -- Find config files
      { "<leader>ff", LazyVim.pick("files"), desc = "Find Files" },
      { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fg", false }, -- Find git files
      { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- git
      { "<leader>gd", false }, -- Git diff
      { "<leader>gs", false }, -- Git status
      { "<leader>gS", false }, -- Git stash
      { "<leader>gc", false }, -- Git log
      -- Grep
      { "<leader>sb", false }, -- Buffer lines
      { "<leader>sB", false }, -- Grep open buffers
      { "<leader>sg", false }, -- grep root
      { "<leader>sG", false }, -- grep cwd
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sw", false }, -- grep word root
      { "<leader>sW", false }, -- grep word cwd
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", false }, -- Diagnostics
      { "<leader>sD", false }, -- Buffer Diagnostics
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", false }, -- Jumps
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", false }, -- Locations
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", false }, -- Marks
      { "<leader>sR", false }, -- Resume?
      { "<leader>sq", false }, -- Quickfix
      { "<leader>su", false }, -- Undo
      -- ui
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

      -- 
      -- override + additional keymaps
      --

      -- Explorer - disable keybind
      { "<leader>e", "", desc = "+edit", mode = { "n", "v" } },
      { "<leader>E", false },

      -- Common
      { "<leader>,", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers" },
      { "<leader><space>", function() Snacks.picker.smart({ cwd = LazyVim.root.git(), hidden = true }) end, desc = "Smart Find Files" },
      { "<leader>/", function() Snacks.picker.git_grep({ cwd = LazyVim.root.git(), hidden = true }) end, desc = "Grep" },

      -- Find
      { "<leader>fg", LazyVim.pick("live_grep", { hidden = true }), desc = "Grep" }, -- TODO cwd grep
      { "<leader>fG", LazyVim.pick("live_grep", { root = false, hidden = true }), desc = "Grep (cwd)" },
      { "<leader>fw", LazyVim.pick("grep_word", { hidden = true }), desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>fW", LazyVim.pick("grep_word", { root = false, hidden = true }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },

      -- Buffer
      { "<leader>b/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>:bd<cr>", desc = "Delete Buffer and Window" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<leader>br", function() Snacks.rename.rename_file() end, desc= "Rename File" },
      { "<leader>bs", function() Snacks.scratch() end, desc = "Scratch Buffer" },
      { "<leader>bS", function() Snacks.scratch.select() end, desc = "Scratch Buffer Select" },

      -- LSP
      { "<leader>xf", "", desc = "+fuzzy" },
      { "<leader>xfd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>xfq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

      -- Terminal
      { "<c-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, desc = "Terminal" },
      { "<c-_>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, desc = "which_key_ignore" },
      { "<C-/>", "<cmd>close<cr>", desc = "Hide Terminal", mode = "t" },
      { "<c-_>", "<cmd>close<cr>", desc = "which_key_ignore", mode = "t" },
      { "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },

      -- Git
      { "<leader>gg", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log() end, desc = "Git Log (cwd)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Current File History" },
      { "<leader>gw", function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
      { "<leader>gW", function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false, }) end, desc = "Git Browse (copy)", mode = { "n", "x" } },

      -- Notifier
      { "<leader>n", "", desc = "+notification", mode = { "n", "v" } },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>nc", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "<leader>ss", false },
        { "<leader>sS", false },

        -- override
        { "<leader>cs", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
        { "<leader>cS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },

      -- override
      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>fT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
