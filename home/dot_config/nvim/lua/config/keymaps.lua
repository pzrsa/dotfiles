-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- DISABLE ALL <leader>f* keybindings from LazyVim (they conflict with our simple <leader>f)
local function del(mode, key)
  pcall(vim.keymap.del, mode, key)
end

-- Snacks keybindings to disable
del("n", "<leader><space>") -- Find Files
del("n", "<leader>,") -- Buffers
del("n", "<leader>.") -- Scratch buffer (conflicts with code action)
del("n", "<leader>/") -- Grep
del("n", "<leader>:") -- Command History
del("n", "<leader>fb") -- Buffers
del("n", "<leader>fB") -- Buffers (all)
del("n", "<leader>fc") -- Find Config
del("n", "<leader>fe") -- Explorer
del("n", "<leader>fE") -- Explorer (cwd)
del("n", "<leader>ff") -- Find Files
del("n", "<leader>fF") -- Find Files (cwd)
del("n", "<leader>fg") -- Git Files
del("n", "<leader>fn") -- New File
del("n", "<leader>fp") -- Projects
del("n", "<leader>fr") -- Recent
del("n", "<leader>fR") -- Recent (cwd)
del("n", "<leader>fT") -- Terminal (cwd)
del("n", "<leader>ft") -- Terminal
del("n", "<leader>e") -- Explorer
del("n", "<leader>E") -- Explorer (cwd)

-- Clear search highlight with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })

-- Buffer navigation (Shift+hl)
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Copy relative path
vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
vim.keymap.set("n", "<leader>cp", "<cmd>CopyRelPath<cr>", { desc = "Copy relative path" })

-- File/buffer navigation
vim.keymap.set("n", "<leader>f", function()
  Snacks.picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>b", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>;", function()
  Snacks.picker.resume()
end, { desc = "Resume" })

-- File explorer (Ctrl+E like your old config)
vim.keymap.set("n", "<C-e>", function()
  Snacks.explorer()
end, { desc = "Explorer" })

-- LSP keymaps
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code action" })

-- Trouble keymaps (references in full buffer like Zed)
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>", { desc = "References" })
vim.keymap.set("n", "]r", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Next reference" })
vim.keymap.set("n", "[r", function()
  require("trouble").prev({ skip_groups = true, jump = true })
end, { desc = "Prev reference" })

-- Diagnostics
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
