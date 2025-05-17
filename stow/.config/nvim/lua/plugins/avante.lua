if vim.g.vscode then
  return {}
end

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },

    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      -- { "<leader>at", ":AvanteToggle<cr>", desc = "Toggle", mode = { "n", "v" } },
      -- { "<leader>aa", ":AvanteAsk<cr>", desc = "Ask", mode = { "n", "v" } },
      { "<leader>ab", ":AvanteBuild<cr>", desc = "avante: build dependencies", mode = { "n", "v" } },
      -- { "<leader>ac", ":AvanteChat<cr>", desc = "Chat", mode = { "n", "v" } },
      -- { "<leader>aC", ":AvanteChatNew<cr>", desc = "New Chat", mode = { "n", "v" } },
      -- { "<leader>ae", ":AvanteEdit<cr>", desc = "Edit", mode = { "v" } },
      -- { "<leader>ah", ":AvanteHistory<cr>", desc = "History", mode = { "n" } },
      -- { "<leader>ar", ":AvanteRefresh<cr>", desc = "Refresh", mode = { "n" } },
      -- { "<leader>aR", ":AvanteClear<cr>", desc = "Clear", mode = { "n" } },
      -- { "<leader>as", ":AvanteStop<cr>", desc = "Stop", mode = { "n" } },
      -- { "<leader>ap", ":AvanteShowRepoMap<cr>", desc = "Repo Map", mode = { "n" } },
      -- { "<leader>aP", ":AvanteSwitchProvider<cr>", desc = "Switch Provider", mode = { "n" } },
      -- { "<leader>am", ":AvanteModels<cr>", desc = "Models", mode = { "n" } },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        -- Add 'avante' to the list
        default = { "avante" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
        },
      },
    },
  },
}
