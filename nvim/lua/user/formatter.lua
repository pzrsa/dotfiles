local formatter = require("formatter")

formatter.setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier,
		},
	},
})
vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
