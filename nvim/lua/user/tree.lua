local tree = require("nvim-tree")

tree.setup({
	filters = {
		exclude = { "node_modules", ".git" },
	},
})

vim.cmd([[
nnoremap <leader>t <cmd>:NvimTreeToggle<cr>
]])
