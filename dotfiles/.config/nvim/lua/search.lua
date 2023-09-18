return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
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
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          }
        }
      })
      telescope.load_extension("fzf")
    end
  }
}
