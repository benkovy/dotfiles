return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "javascript", "typescript", "ruby", "json", "yaml", "lua", "tsx", "norg" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
