local tree = require("nvim-tree")

tree.setup({
	filters = {
		custom = { "node_modules", "^.git$" },
	},
})

vim.cmd([[
nnoremap <C-n> <cmd>:NvimTreeToggle<cr>
]])
