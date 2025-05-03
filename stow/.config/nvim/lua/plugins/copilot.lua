if vim.g.vscode then
  return {}
end

vim.g.ai_cmp = false

return {
  -- Import copilot from extras and override filetypes
  { import = "lazyvim.plugins.extras.ai.copilot" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<M-h>",
          accept = "<M-l>",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
      },
    },
  },

  -- Import copilot-chat from extras and override keymaps
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      settings = {
        model = "claude-3.7-sonnet-thought",
        context = "buffers",
        temperature = 0.1,
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>aa", false }, -- disable original chat keymap

      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>aS", ":CopilotChatStop<cr>", desc = "Stop Chat Output (CopilotChat)" },
      { "<leader>aM", ":CopilotChatModels<cr>", desc = "Chat Models (CopilotChat)" },
      { "<leader>ar", ":CopilotChatReset<cr>", desc = "Clear (CopilotChat)", mode = { "n", "v" } },
      { "<leader>a=", ":tabdo wincmd =<cr>", desc = "Equalize windows", mode = { "n", "v" } },

      {
        "<leader>ac",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },

      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },

      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
}
