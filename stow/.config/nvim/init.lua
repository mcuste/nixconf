if vim.g.vscode then
  -- VSCode extension
  require("config.options")
  -- require("config.keymaps")
  -- require("config.autocmds")
else
  -- Default Nvim config
  require("config.lazy")
end
