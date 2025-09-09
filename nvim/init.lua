vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true
vim.opt.laststatus = 3
vim.g.have_nerd_font = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.wrap = false

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set("n", "<S-h>", "<cmd>bp<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bn<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "find files" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "live grep" })
vim.keymap.set("n", "<leader>o", "<cmd>FzfLua oldfiles<cr>", { desc = "old files" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "buffers" })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<cr>", { desc = "find help" })
vim.keymap.set("n", "<leader>k", "<cmd>FzfLua keymaps<cr>", { desc = "find keymaps" })
vim.keymap.set("n", "<leader>'", "<cmd>FzfLua resume<cr>", { desc = "last picker" })

vim.cmd([[
    cnoreabbrev w wa
    cnoreabbrev W wa
]])

vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { { "borderless-full" }, defaults = { formatter = { "path.filename_first", 2 } } },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { preset = "helix" },
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function()
					vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "goto definition" })
					vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "goto references" })
					vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementationscr>", { desc = "goto implementation" })
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename" })
					vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "code action" })
				end,
			})

			vim.diagnostic.config({
				virtual_text = true,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						runtime = { version = "LuaJIT" },
					},
				},
			})

			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							complete_function_calls = true,
							tsserver_file_preferences = {
								importModuleSpecifierPreference = "relative",
							},
						},
					},
				},
			})

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("prismals")
			vim.lsp.enable("astro")
			vim.lsp.enable("basedpyright")
			vim.lsp.enable("vtsls")
			vim.lsp.enable("jsonls")
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			complete_function_calls = true,
	-- 			tsserver_file_preferences = {
	-- 				importModuleSpecifierPreference = "relative",
	-- 			},
	-- 		},
	-- 	},
	-- },

	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				markdown = { "prettierd" },
				astro = { "prettierd" },
			},
		},
	},

	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		dependencies = { "rafamadriz/friendly-snippets", "Kaiser-Yang/blink-cmp-avante" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"avante",
				},
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
				},
			},
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"css",
					"javascript",
					"typescript",
					"json",
					"lua",
					"go",
					"markdown",
					"python",
					"regex",
					"sql",
					"tsx",
				},
				auto_install = false,
				sync_install = true,
				modules = {},
				autopairs = {
					enable = true,
				},
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_foreground = "mix"
	-- 		vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
	-- 		vim.g.gruvbox_material_transparent_background = 1
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<C-e>",
				function()
					require("neo-tree.command").execute({ toggle = true, position = "current", reveal = true })
				end,
				desc = "Explorer NeoTree",
			},
		},
		lazy = false,
		opts = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
	{ "bluz71/nvim-linefly" },
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = true,
		opts = {
			check_ts = true,
		},
	},
	{ "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
	{
		"f-person/auto-dark-mode.nvim",
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = false },
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
		},
	},
})

vim.cmd.colorscheme("tokyonight")
