return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },

    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = 'icons',
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
      },

      inlay_hints = {
        enabled = true,
        exclude = {}, -- filetypes for which you don't want to enable inlay hints
        -- exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
      },

      -- Need to configure lsps to support codelens TODO
      codelens = { enabled = false },

      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },

      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        -- lua_ls = {
        --   -- mason = false, -- set to false if you don't want this server to be installed with mason
        --   -- Use this to add any additional keymaps
        --   -- for specific lsp servers
        --   -- ---@type LazyKeysSpec[]
        --   -- keys = {},
        --   settings = {
        --     -- Lua = {
        --     --   workspace = {
        --     --     checkThirdParty = false,
        --     --   },
        --     --   codeLens = {
        --     --     enable = true,
        --     --   },
        --     --   completion = {
        --     --     callSnippet = 'Replace',
        --     --   },
        --     --   doc = {
        --     --     privateName = { '^_' },
        --     --   },
        --     --   hint = {
        --     --     enable = true,
        --     --     setType = false,
        --     --     paramType = true,
        --     --     paramName = 'Disable',
        --     --     semicolon = 'Disable',
        --     --     arrayIndex = 'Disable',
        --     --   },
        --     -- },
        --   },
        -- },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },

    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- LazyVim.lsp.setup()
      -- LazyVim.lsp.on_dynamic_capability(require('lazyvim.plugins.lsp.keymaps').on_attach)

      -- diagnostics signs
      if type(opts.diagnostics.signs) ~= 'boolean' then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
          name = 'DiagnosticSign' .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
        end
      end

      -- -- inlay hints
      -- if opts.inlay_hints.enabled then
      --   LazyVim.lsp.on_supports_method('textDocument/inlayHint', function(client, buffer)
      --     if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == '' and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype) then
      --       vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      --     end
      --   end)
      -- end
      
      -- code lens
      -- if opts.codelens.enabled and vim.lsp.codelens then
      --   LazyVim.lsp.on_supports_method('textDocument/codeLens', function(client, buffer)
      --     vim.lsp.codelens.refresh()
      --     vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      --       buffer = buffer,
      --       callback = vim.lsp.codelens.refresh,
      --     })
      --   end)
      -- end

      if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has 'nvim-0.10.0' == 0 and '●'
          or function(diagnostic)
            local icons = {
              Error = ' ',
              Warn = ' ',
              Hint = ' ',
              Info = ' ',
            }
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_blink, blink = pcall(require, 'blink.cmp')
      local capabilities =
        vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), has_blink and blink.get_lsp_capabilities() or {}, opts.capabilities or {})

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup {
          ensure_installed = ensure_installed,
          handlers = { setup },
        }
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local snacks_picker = function(keys, fn, desc)
            return map(keys, function()
              return Snacks[fn]()
            end, desc)
          end

          map("gd", vim.lsp.buf.definition, "Definition")
          map('gD', vim.lsp.buf.declaration, 'Declaration')
          map("gI", vim.lsp.buf.implementation, "Implementation" )
          map("K", vim.lsp.buf.hover, "Hover" )
          map("gK", vim.lsp.buf.signature_help, "Signature")
          map( "<c-k>", vim.lsp.buf.signature_help, "Signature", "i")
          map("ga", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map('gr', vim.lsp.buf.rename, 'Rename')
          
          -- map("ge", vim.lsp.buf.references, "References" )
          -- map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition" )
          
          map(']]', function() -- word (lsp)
            Snacks.words.jump(vim.v.count1)
          end, 'Next Reference', { 'n', 't' })
          map('[[', function() -- word (lsp)
            Snacks.words.jump(-vim.v.count1)
          end, 'Prev Reference', { 'n', 't' })

          map("<leader>lc", vim.lsp.codelens.run, "Codelens", { "n", "v" })
          map("<leader>lC", vim.lsp.codelens.refresh, "Refresh Codelens", { "n" })

          snacks_picker( '<leader>lfd', 'lsp_definitions', 'Definitions')
          snacks_picker( '<leader>lfD', 'lsp_declarations', 'Declarations')
          snacks_picker( '<leader>lfr', 'lsp_references', 'References')
          snacks_picker( '<leader>lfi', 'lsp_implementations', 'Implementations')
          snacks_picker( '<leader>lft', 'lsp_type_definitions', 'Type Definitions')
          snacks_picker( '<leader>lfs', 'lsp_symbols', 'LSP Symbols')
          snacks_picker( '<leader>lfS', 'lsp_workspace_symbols', 'LSP Workspace Symbols')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
    end,
  },

  -- cmdline tools and lsp servers
  {

    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },

    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger {
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
