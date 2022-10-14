local tree = require("nvim-tree")

tree.setup({
	filters = {
		custom = { "node_modules", "^.git$" },
		dotfiles = true,
	},
})

vim.cmd([[
nnoremap <C-n> <cmd>:NvimTreeToggle<cr>
]])
