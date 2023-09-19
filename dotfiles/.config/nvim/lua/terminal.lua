return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup()

    vim.api.nvim_set_keymap('n', 'tt', ':ToggleTerm<CR>', { noremap = true, silent = true })
  end
}
