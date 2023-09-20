return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      lsp.nvim_workspace()

      lsp.set_server_config({
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      lsp.ensure_installed({
        'tsserver',
        'graphql',
        'lua_ls'
      })

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
        }
      })

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })

        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end
        })
      end)

      lsp.setup()
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier",
          "stylelua"
        },
        automatic_installation = true,
        handlers = {},
      })
    end,
  }
}
