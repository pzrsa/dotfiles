vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
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

vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>BufferClose<cr>", { desc = "Close buffer" })

vim.keymap.set("n", "<leader>G", "<cmd>Gitsigns<cr>", { desc = "Gitsigns" })

vim.cmd([[
    cnoreabbrev w wa
    cnoreabbrev W wa
]])

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { preset = "helix" },
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = { hidden = true },
				},
				defaults = {
					file_ignore_patterns = { "node_modules", ".git" },
					path_display = function(_, path)
						local tail = require("telescope.utils").path_tail(path)
						return string.format("%s (%s)", tail, path)
					end,
					layout_strategy = "center",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top", -- search bar at the top
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Telescope diagnostics" })
			vim.keymap.set("n", "<leader>R", builtin.oldfiles, { desc = "Telescope recent files" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope find help" })
			vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Telescope find keymaps" })
			vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Telescope last picker" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("<leader>s", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("<leader>r", vim.lsp.buf.rename, "Rename")
					map("<leader>.", vim.lsp.buf.code_action, "Code Action")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, "Go to previous error message")
					map("]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, "Go to next error message")
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

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("eslint")
			vim.lsp.enable("prismals")
			vim.lsp.enable("astro")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				complete_function_calls = true,
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "relative",
				},
			},
		},
	},

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
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "enter" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = { documentation = { auto_show = false } },

			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					-- "avante"
				},
				-- providers = {
				-- 	avante = {
				-- 		module = "blink-cmp-avante",
				-- 		name = "Avante",
				-- 		opts = {},
				-- 	},
				-- },
			},
			-- Experimental signature help support
			signature = { enabled = true },

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
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
			})
		end,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.g.gruvbox_material_transparent_background = 1
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

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

	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			tabpages = true,
			sidebar_filetypes = {
				["neo-tree"] = true,
			},
		},
		version = "^1.0.0",
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

	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	version = false,
	-- 	opts = {
	-- 		provider = "copilot",
	-- 		providers = {
	-- 			copilot = {
	-- 				model = "claude-sonnet-4",
	-- 			},
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"echasnovski/mini.pick", -- for file_selector provider mini.pick
	-- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
})
