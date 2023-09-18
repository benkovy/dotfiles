return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local tree = require("nvim-tree")
    tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      view = {
        width = 30,
        hide_root_folder = false,
        side = "right",
        number = false,
        relativenumber = false,
      },
    })

    vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
  end,
}
