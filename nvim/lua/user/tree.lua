local tree = require("nvim-tree")

tree.setup({
	filters = {
		custom = { "node_modules", "^.git$" },
		dotfiles = true,
	},
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
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
