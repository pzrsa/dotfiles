-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by plugins.core
local del = vim.keymap.del

del("n", "<leader>xl")
del("n", "<leader>xq")
del("n", "<leader>uL")
del("n", "<leader>ul")
del("n", "<leader>uc")
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
	del("n", "<leader>uh")
end
del("n", "<leader>ub")
