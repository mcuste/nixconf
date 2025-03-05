local map = function(lhs, rhs, desc, mode)
  local result = {
    lhs,
    rhs,
    desc = desc,
  }
  if mode then
    result.mode = mode
  end
  return result
end

local snacks_map = function(opts)
  local lhs = '<leader>' .. opts.sfx
  local rhs = function()
    if opts.grp then
      if opts.args then
        return Snacks[opts.grp][opts.fn](unpack(opts.args))
      else
        return Snacks[opts.grp][opts.fn]()
      end
    else
      if opts.args then
        return Snacks[opts.fn](unpack(opts.args))
      else
        return Snacks[opts.fn]()
      end
    end
  end
  return map(lhs, rhs, opts.desc, opts.mode)
end

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      -- -- disabled parts
      explorer = { enabled = false },
      scroll = { enabled = false },
      image = { enabled = false }, -- using zellij?

      -- -- enabled parts
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true }, -- not sure what this does
      words = { enabled = true },
      picker = { enabled = true },
      indent = { enabled = true },

      -- -- installed automatically
      -- animate (not used directly, used by others)
      -- bufdelete
      -- debug
      -- dim
      -- git (TODO Snacks.git.get_root())
      -- gitbrowse
      -- layout (not used directly, used by others?)
      -- lazygit
      -- notify (not used directly, used by others?)
      -- profiler (not used directly, used by others?)
      -- rename
      -- scratch
      -- terminal
      -- toggle
      -- util (not used directly, used by others)
      -- win (not used directly, used by others)
      -- zen (not using)

      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },

    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- debug -- pretty print lua objects with dd()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end

          -- debug -- pretty print backtrace with bt()
          _G.bt = function()
            Snacks.debug.backtrace()
          end

          -- debug -- Override print to use snacks for `:=` command
          vim.print = _G.dd

          -- Some toggle mappings
          Snacks.toggle.diagnostics():map '<leader>ud' -- toggle
          Snacks.toggle.treesitter():map '<leader>ut' -- toggle
          Snacks.toggle.inlay_hints():map '<leader>uy' -- toggle
          Snacks.toggle.indent():map '<leader>un' -- indent -- toggle
          Snacks.toggle.dim():map '<leader>um' -- dim -- toggle
        end,
      })

      -- rename -- Notify LSP when file name changes on Oil
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilActionsPost',
        callback = function(event)
          if event.data.actions.type == 'move' then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,

    keys = {
      -- Fuzzy find
      snacks_map { sfx = '<space>', grp = 'picker', fn = 'smart', desc = 'Smart Find Files' }, -- picker
      snacks_map { sfx = 'ff', grp = 'picker', fn = 'git_files', desc = 'Find Git Files' }, -- picker
      snacks_map { sfx = 'fF', grp = 'picker', fn = 'files', desc = 'Find Files' }, -- picker
      snacks_map { sfx = 'fg', grp = 'picker', fn = 'git_grep', desc = 'Git Grep' }, -- picker
      snacks_map { sfx = 'fG', grp = 'picker', fn = 'grep', desc = 'Grep' }, -- picker
      snacks_map { sfx = 'fc', grp = 'picker', fn = 'command_history', desc = 'Command History' }, -- picker
      snacks_map { sfx = 'fp', grp = 'picker', fn = 'projects', desc = 'Projects' }, -- picker
      snacks_map { sfx = 'fr', grp = 'picker', fn = 'recent', desc = 'Recent' }, -- picker

      -- Fuzzy search
      snacks_map { sfx = 'si', grp = 'picker', fn = 'icons', desc = 'Icons' }, -- picker
      snacks_map { sfx = 'sk', grp = 'picker', fn = 'keymaps', desc = 'Keymaps' }, -- picker
      snacks_map { sfx = 'sh', grp = 'picker', fn = 'help', desc = 'Help Pages' }, -- picker
      snacks_map { sfx = 'sm', grp = 'picker', fn = 'man', desc = 'Man Pages' }, -- picker
      snacks_map { sfx = 'sc', grp = 'picker', fn = 'commands', desc = 'Commands' }, -- picker
      snacks_map { sfx = 'su', grp = 'picker', fn = 'undo', desc = 'Undo History' }, -- picker
      snacks_map { sfx = 's"', grp = 'picker', fn = 'registers', desc = 'Registers' }, -- picker
      snacks_map { sfx = 's/', grp = 'picker', fn = 'search_history', desc = 'Search History' }, -- picker

      -- Buffer
      snacks_map { sfx = 'bd', fn = 'bufdelete', desc = 'Delete Buffer' }, -- bufdelete
      snacks_map { sfx = 'bD', grp = 'bufdelete', fn = 'other', desc = 'Delete Other Buffers' }, -- bufdelete
      snacks_map { sfx = 'br', grp = 'rename', fn = 'rename_file', desc = 'Rename File' }, -- rename
      snacks_map { sfx = 'bs', grp = 'scratch', fn = 'toggle', desc = 'Toggle Scratch Buffer' }, -- scratch
      snacks_map { sfx = 'bS', grp = 'scratch', fn = 'select', desc = 'Select Scratch Buffer' }, -- scratch
      snacks_map { sfx = 'bf', grp = 'picker', fn = 'buffers', desc = 'Buffers' }, -- picker
      snacks_map { sfx = 'bl', grp = 'picker', fn = 'lines', desc = 'Buffer Lines' }, -- picker

      -- Git
      snacks_map { sfx = 'gB', grp = 'git', fn = 'blame_line', desc = 'Blame' }, -- git
      snacks_map { sfx = 'gw', fn = 'gitbrowse', desc = 'Git Browse', mode = { 'n', 'v' } }, -- gitbrowse
      snacks_map { sfx = 'gg', fn = 'lazygit', desc = 'Lazygit' }, -- lazygit
      snacks_map { sfx = 'gl', grp = 'picker', fn = 'git_log', desc = 'Git Log' }, -- picker
      snacks_map { sfx = 'go', grp = 'picker', fn = 'git_log_line', desc = 'Git Log Line' }, -- picker

      -- Notifications
      snacks_map { sfx = 'nc', grp = 'notifier', fn = 'hide', desc = 'Clear Notifications' }, -- notifier
      snacks_map { sfx = 'nh', grp = 'notifier', fn = 'show_history', desc = 'Notifications History' }, --notifier

      -- Terminal
      map('<c-/>', function() -- terminal
        Snacks.terminal()
      end, 'Toggle Terminal'),
    },
  },

  -- Disable autopairs in snacks picker
  {
    'windwp/nvim-autopairs',
    opts = { disable_filetype = { 'snacks_picker_list', 'snacks_picker_input' } },
  },

  -- Use bufdelete for bufferline close command
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
      },
    },
  },
}
