return {
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
    })

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
      lsp.buffer_autoformat()
    end)

    lsp.setup()
  end
}
