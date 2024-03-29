vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.wo.signcolumn = "yes"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.wo.number = true         -- Show line number
vim.wo.relativenumber = true -- Use relative line numbers
vim.o.cmdheight = 2          -- Height of the command bar
vim.o.hidden = true          -- A buffer becomes hidden when it is abandoned
vim.o.showmatch = true       -- Show matching brackets when text indicator is over them
vim.o.matchtime = 2          -- How many tenths of a second to blink when matching brackets
vim.o.laststatus = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.o.updatetime = 250

require("lazy").setup({
  require("tree"),
  require("theme"),
  require("tabs"),
  require("completion"),
  require("search"),
  require("treesitter"),
  require("lsp"),
  require("org"),
  require("status"),
  require("git"),
  require("autopair"),
  require("terminal"),
})
