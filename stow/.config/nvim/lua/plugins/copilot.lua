return {
  {
    'zbirenbaum/copilot.lua',
    cmd = { 'Copilot' },
    event = { 'InsertEnter' },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        autoTrigger = true,
        keymap = {
          accept_word = false,
          accept_line = false,
          accept = '<C-l>',
          dismiss = '<C-h>',
          next = '<C-j>',
          prev = '<C-k>',
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

    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },

    build = 'make tiktoken', -- Only on MacOS or Linux

    opts = {
      debug = false,
      model = 'claude-3.5-sonnet',
      temperature = 0.1,
      context = 'buffers',
    },

    keys = {
      -- Generic chat
      { '<leader>cc', ':CopilotChatToggle<cr>', desc = 'Toggle Chat' },
      { '<leader>cS', ':CopilotChatStop<cr>', desc = 'Stop Chat Output' },
      { '<leader>cM', ':CopilotChatModels<cr>', desc = 'Chat Models' },
    },
  },
}
