-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Additional options from your original config
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.laststatus = 3 -- Global statusline

-- Use basedpyright for Python LSP (you had this in your old config)
vim.g.lazyvim_python_lsp = "basedpyright"

-- Fix markdown invisible text (conceallevel hides links)
vim.opt.conceallevel = 0 -- Show all concealed text (markdown links, etc.)

-- Make w/W save all buffers
vim.cmd([[
  cnoreabbrev w wall
  cnoreabbrev W wall
]])
