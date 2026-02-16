-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Use absolute line numbers
vim.opt.scrolloff = 10 -- More context lines
vim.opt.conceallevel = 0 -- Show all text (markdown links, etc.)

-- Make w/W save all buffers
vim.cmd([[
  cnoreabbrev w wall
  cnoreabbrev W wall
]])
