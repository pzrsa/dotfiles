local tree = require("nvim-tree")

tree.setup({
	filters = {
		custom = { "node_modules", "^.git$", "out" },
		dotfiles = true,
	},
	view = {
		adaptive_size = true,
		float = {
			enable = true,
			open_win_config = {
				width = 50,
				height = 60,
			},
		},
	},
})

vim.cmd([[
nnoremap <C-n> <cmd>:NvimTreeFindFileToggle<cr>
nnoremap <C-A-n> <cmd>:NvimTreeToggle<cr>
]])
