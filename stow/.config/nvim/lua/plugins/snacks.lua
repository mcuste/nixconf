-- override snacks
return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      scroll = { enabled = false },
    },

    keys = {
      -- == EXPLORER == - disable keybind
      { "<leader>e", "", desc = "+edit", mode = { "n", "v" } },
      { "<leader>E", false },

      -- == NOTIFIER ==
      { "<leader>n", false },
      { "<leader>n", "", desc = "+notification", mode = { "n", "v" } },
      -- stylua: ignore
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      -- stylua: ignore
      { "<leader>nc", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

      -- == COMMAND ==
      { "<leader>sC", false }, -- disable other search commands keybind
      -- stylua: ignore
      { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },

      -- == TERMINAL ==
      -- stylua: ignore
      { "<c-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, desc = "Terminal" },
      -- stylua: ignore
      { "<c-_>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, desc = "which_key_ignore" },
      { "<C-/>", "<cmd>close<cr>", desc = "Hide Terminal", mode = "t" },
      { "<c-_>", "<cmd>close<cr>", desc = "which_key_ignore", mode = "t" },
      { "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },

      -- == BUFFER ==
      { "<leader>S", false },
      -- stylua: ignore
      { "<leader>,", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers" },
      { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      { "<leader>bD", "<cmd>:bd<cr>", desc = "Delete Buffer and Window" },
      -- stylua: ignore
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      -- stylua: ignore
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<leader>fb", false }, -- disable othe buffer fuzzy finds from snacks_picker extra plugins
      { "<leader>fB", false },
      { "<leader>sB", false },
      -- stylua: ignore
      { "<leader>b/", function() Snacks.picker.lines() end, desc = "Buffer Grep" },
      -- stylua: ignore
      { "<leader>br", function() Snacks.rename.rename_file() end, desc= "Rename File" },
      -- stylua: ignore
      { "<leader>bs", function() Snacks.scratch.toggle() end, desc = "Scratch Buffer" },
      -- stylua: ignore
      { "<leader>bS", function() Snacks.scratch.select() end, desc = "Scratch Buffer Select" },

      -- == GIT ==
      { "<leader>gs", false }, -- disable git status
      { "<leader>gS", false }, -- disable git stash
      { "<leader>gd", false }, -- disable git diff
      { "<leader>gc", false }, -- disable git log
      -- stylua: ignore
      { "<leader>gg", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end, desc = "Lazygit" },
      -- stylua: ignore
      { "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, desc = "Git Log" },
      -- stylua: ignore
      { "<leader>gL", function() Snacks.picker.git_log() end, desc = "Git Log (cwd)" },
      -- stylua: ignore
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Current File History" },
      -- stylua: ignore
      { "<leader>gw", function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
      -- stylua: ignore
      { "<leader>gW", function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false, }) end, desc = "Git Browse (copy)", mode = { "n", "x" } },

      -- == Find ==
      { "<leader>fc", false }, -- disable config finder
      -- stylua: ignore
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files (Git)" },
      -- stylua: ignore
      { "<leader>/", function() Snacks.picker.git_grep() end, desc = "Grep (Git)" },
      { "<leader>fg", false }, -- disable unused find git files
      { "<leader>fg", LazyVim.pick("live_grep"), desc = "Grep (Root)" },
      -- stylua: ignore
      { "<leader>ff", function() Snacks.picker.git_files() end, desc = "Find Files (Git)" },
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root)" },
      { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<leader>fR", false }, -- disable cwd recent files
      -- stylua: ignore
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root)", mode = { "n", "x" } },

      -- == Search ==
      { "<leader>sB", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sp", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>sD", false },
      { "<leader>sj", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sR", false },
      { "<leader>su", false },
      { "<leader>sd", false },
      { "<leader>sq", false },

      -- stylua: ignore
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      -- stylua: ignore
      { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
      -- stylua: ignore
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      -- stylua: ignore
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      -- stylua: ignore
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      -- stylua: ignore
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      -- stylua: ignore
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      -- stylua: ignore
      { "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
      -- stylua: ignore
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

      -- == LSP ==
      { "<leader>xf", "", desc = "+fuzzy" },
      -- stylua: ignore
      { "<leader>xfd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      -- stylua: ignore
      { "<leader>xfq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "<leader>ss", false},
        { "<leader>sS", false}
      })
    end,
  },
}
