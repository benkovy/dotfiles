return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {
          config = {
            icons_preset = "diamond",
          }
        },                  -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              work = "~/notes/work",
              personal = "~/notes/personal",
            },
            default_workspace = "work"
          },
        },
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")

              keybinds.remap_event("norg", "n", "<leader>N", "core.dirman.new.note")
            end,
          },
        },
      },
    })

    -- vim.api.nvim_set_keymap('n', '<leader>w', ':bd<CR>', { noremap = true, silent = true })
  end,
}
