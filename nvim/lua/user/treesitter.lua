local configs = require("nvim-treesitter.configs")

configs.setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"lua",
		"typescript",
		"tsx",
		"go",
		"markdown",
		"vim",
		"dockerfile",
		"cpp",
		"c",
		"java",
		"javascript",
		"sql",
		"python",
		"proto",
		"make",
		"kotlin",
		"jsonc",
		"gomod",
		"dart",
		"css",
		"bash",
		"html",
		"markdown_inline",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,
	indent = {
		enable = true,
		disable = { "python" },
	},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
})
