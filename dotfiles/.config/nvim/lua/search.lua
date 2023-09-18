return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>F', function()
      builtin.find_files({ hidden = true })
    end, {})
    vim.keymap.set('n', '<leader>f', function()
      builtin.live_grep({ hidden = true })
    end, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules", "build", "dist", "yarn.lock", "^.git/"
        },
      }
    })
  end
}
