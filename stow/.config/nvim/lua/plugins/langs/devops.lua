return {
  { import = "lazyvim.plugins.extras.lang.ansible" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.helm" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "awk",
        "desktop",
        "devicetree",
        "gpg",
        "make",
        "just",
        "jq",
        "nginx",
        "ssh_config",
        "tmux",
        "groovy",
      },
    },
  },
}
