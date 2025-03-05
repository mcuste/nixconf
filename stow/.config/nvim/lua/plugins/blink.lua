return {
  'saghen/blink.cmp',
  version = '*',
  event = 'InsertEnter',

  opts_extend = {
    'sources.completion.enabled_providers',
    'sources.compat',
    'sources.default',
  },

  dependencies = {
    {
      'saghen/blink.compat',
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
      version = '*',
    },
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false, -- fallback to nvim-cmp's highlight groups
      nerd_font_variant = 'mono',
    },

    keymap = { preset = 'default' },
    cmdline = { enabled = false },
    signature = { enabled = true },
    fuzzy = { implementation = 'prefer_rust_with_warning' }, -- use rust bin

    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { draw = { treesitter = { 'lsp' } } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = { enabled = false }, -- copilot uses ghost test already
    },

    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { 'lsp', 'path', 'buffer' },
    },
  },

  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend('force', { name = source, module = 'blink.compat.source' }, opts.sources.providers[source] or {})
      if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    require('blink.cmp').setup(opts)
  end,
}
