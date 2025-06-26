if vim.g.vscode then
  return {}
end

return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua",
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true, -- Use local `mcp-hub` binary
        -- Absolute path to MCP Servers config file (will create if not exists)
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
      })
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",

      -- copilot = {
      --   model = "claude-sonnet-4-0",
      -- },

      -- Disable built-in tools to prevent conflicts with MCP provided tools
      disabled_tools = {
        "list_files", -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash", -- Built-in terminal access
      },

      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,

      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
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
