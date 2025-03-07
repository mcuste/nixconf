local function read_file(path)
  if path:sub(1, 2) == "~/" then
    path = os.getenv("HOME") .. path:sub(2)
  end
  local file = io.open(path, "r")
  if not file then
    print("Could not open file " .. path)
    return nil
  end
  local content = file:read("*a"):gsub("^%s*(.-)%s*$", "%1")
  file:close()
  return content
end

return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      require("codecompanion").setup({
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = read_file("~/.ssh/openai.key"),
              },
              schema = {
                model = {
                  default = "o3-mini",
                },
              },
            })
          end,
        },

        strategies = {
          chat = {
            adapter = "openai",
          },
          inline = {
            adapter = "openai",
          },
        },

        display = {
          chat = {
            window = {
              position = "right",
              opts = {
                number = false,
                relativenumber = false,
                signcolumn = "yes", -- use as a margin on the left side
              },
            },
          },
        },
      })
    end,

    keys = {
      { "<leader>l", "", desc = "+llm", mode = { "n", "v" } },
      { "<leader>lc", ":CodeCompanionChat Toggle<cr>", desc = "Chat (CodeCompanion)", mode = { "n", "v" } },
      { "<leader>lC", ":CodeCompanionChat ", desc = "Quick Chat (CodeCompanion)", mode = { "n", "v" } },
      { "<leader>li", ":CodeCompanion ", desc = "Inline Assistant (CodeCompanion)", mode = { "n", "v" } },
      { "<leader>l:", ":CodeCompanionCmd ", desc = "Cmdline Assistant (CodeCompanion)", mode = { "n", "v" } },
      { "<leader>la", ":CodeCompanionActions", desc = "Actions (CodeCompanion)", mode = { "n", "v" } },
      { "<leader>l=", ":tabdo wincmd =<cr>", desc = "Equalize windows", mode = { "n", "v" } },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
