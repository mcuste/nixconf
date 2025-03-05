return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept_word = false,
          accept_line = false,
          accept = '<M-l>',
          dismiss = '<M-h>',
          next = '<M-j>',
          prev = '<M-k>',
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
      },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    build = 'make tiktoken', -- Only on MacOS or Linux
    event = 'VeryLazy',

    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },

    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = 'claude-3.5-sonnet',
        context = 'buffers',
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
      }
    end,

    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,

    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>cS', ':CopilotChatStop<cr>', desc = 'Stop Chat Output' },
      { '<leader>cM', ':CopilotChatModels<cr>', desc = 'Chat Models' },
      {
        '<leader>cc',
        function()
          require('CopilotChat').toggle()
          vim.cmd 'tabdo wincmd ='
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cr',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cq',
        function()
          vim.ui.input({
            prompt = 'Quick Chat: ',
          }, function(input)
            if input ~= '' then
              require('CopilotChat').ask(input)
              vim.cmd 'tabdo wincmd ='
            end
          end)
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cp',
        function()
          require('CopilotChat').select_prompt()
          vim.cmd 'tabdo wincmd ='
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
  },

  -- Edgy integration for Copilot Chat
  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = 'copilot-chat',
        title = 'Copilot Chat',
        size = { width = 50 },
      })
    end,
  },
}
