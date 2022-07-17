vim.g["lightline"] = {
	colorscheme = "catppuccin",
	active = {
		left = { { "mode", "paste" }, { "readonly", "relativepath", "modified" } },
		right = { { "filetype" }, { "percent" }, { "lineinfo" } },
	},
	tabline = {
		left = { { "buffers" } },
		right = { { "close" } },
	},
	component_expand = {
		buffers = "lightline#bufferline#buffers",
	},
	component_type = {
		buffers = "tabsel",
	},
}

vim.cmd([[
let g:lightline#bufferline#enable_devicons = 1

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
]])
