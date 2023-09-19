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
        'eslint',
        'graphql',
      })

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        lsp.buffer_autoformat()

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
    'mhartington/formatter.nvim',
    config = function()
      local util = require("formatter.util")

      function prettier()
        return {
          exe = 'prettier', -- change this to your prettier path
          args = {
            '--config-precedence',
            'prefer-file',
            '--print-width',
            vim.bo.textwidth,
            '--stdin-filepath',
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
          },
          stdin = true,
        }
      end

      require("formatter").setup({
        filetype = {
          javascript = { prettier },
          typescript = { prettier },
          javascriptreact = { prettier },
          typescriptreact = { prettier },
          ['javascript.jsx'] = { prettier },
          ['typescript.tsx'] = { prettier },
          css = { prettier },
          json = { prettier },
          jsonc = { prettier },
          scss = { prettier },
          yaml = { prettier },
          graphql = { prettier },
          html = { prettier },
        }
      })
    end
  }
}
