-- Based on kickstart.nvim, trimmed and customized for Helix-like feel.
-- Single-file config; everything lives here.
--
-- Deliberate changes vs upstream kickstart:
--   * telescope removed; snacks.picker used instead
--   * tokyonight removed; gruvbox-material used instead
--   * todo-comments removed
--   * bufferline + trouble + rustaceanvim + crates + SchemaStore added
--   * LSP attach keymaps tuned to match user's Helix bindings

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Disable unused language providers (silences checkhealth warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- [[ Options ]]
vim.o.number = true
vim.o.relativenumber = false
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 14 -- Matches helix config
vim.o.confirm = true

-- [[ Diagnostics ]]
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function()
			vim.diagnostic.open_float()
		end,
	},
})

-- [[ Basic keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window nav (helix jump_view_* parity)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Buffer nav (user's helix S-h / S-l)
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Copy relative path
vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})
vim.keymap.set("n", "<leader>cp", "<cmd>CopyRelPath<cr>", { desc = "Copy rel path" })

-- :w / :W → :wall
vim.cmd([[
  cnoreabbrev w wall
  cnoreabbrev W wall
]])

-- [[ Autocmds ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yank",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Autosave on focus lost / buffer leave (helix focus-lost = true parity)
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	group = vim.api.nvim_create_augroup("autosave", { clear = true }),
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})

-- [[ lazy.nvim bootstrap ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("clone lazy.nvim failed:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
	-- Auto-detect indent style per file
	{ "NMAC427/guess-indent.nvim", opts = {} },

	-- Auto-close brackets/quotes (helix auto-pairs parity)
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end
				map("n", "]h", function()
					gs.nav_hunk("next")
				end, "Next hunk")
				map("n", "[h", function()
					gs.nav_hunk("prev")
				end, "Prev hunk")
				map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
			end,
		},
	},

	-- Keymap popup (helix space-menu analog)
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			preset = "helix",
			delay = 0,
			icons = { mappings = vim.g.have_nerd_font },
			spec = {
				{ "<leader>c", group = "Code" },
				{ "<leader>g", group = "Git" },
				{ "<leader>gh", group = "Hunk" },
				{ "<leader>s", group = "Search" },
				{ "<leader>x", group = "Trouble" },
			},
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"b0o/SchemaStore.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("<leader>r", vim.lsp.buf.rename, "Rename")
					map("<leader>.", vim.lsp.buf.code_action, "Code action", { "n", "x" })
					map("K", vim.lsp.buf.hover, "Hover")
					map("gd", vim.lsp.buf.definition, "Goto definition")
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("gI", vim.lsp.buf.implementation, "Goto implementation")
					map("gy", vim.lsp.buf.type_definition, "Goto type def")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>i", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end
				end,
			})

			---@type table<string, vim.lsp.Config>
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
							runtime = { version = "LuaJIT" },
							format = { enable = false },
						},
					},
				},
				vtsls = {
					settings = {
						complete_function_calls = true,
						typescript = { preferences = { importModuleSpecifier = "relative" } },
					},
				},
				tailwindcss = {},
				prismals = {},
				astro = {},
				eslint = {},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				ruff = {
					settings = { format = { preview = true } },
				},
				clangd = { cmd = { "clangd", "--clang-tidy" } },
			}

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua", "prettier", "yamlfmt" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, cfg in pairs(servers) do
				vim.lsp.config(name, cfg)
				vim.lsp.enable(name)
			end

			-- ty: Astral's experimental Python type checker (from $PATH, not mason)
			vim.lsp.config("ty", {
				cmd = { "ty", "server" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
				settings = { experimental = { rename = true, autoImport = true } },
			})
			vim.lsp.enable("ty")
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "x" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local enabled = {
					lua = true,
					javascript = true,
					javascriptreact = true,
					typescript = true,
					typescriptreact = true,
					json = true,
					jsonc = true,
					markdown = true,
					html = true,
					css = true,
					astro = true,
					yaml = true,
					python = true, -- ruff LSP via lsp_format fallback
					rust = true, -- rust-analyzer via lsp_format fallback
				}
				if enabled[vim.bo[bufnr].filetype] then
					return { timeout_ms = 3000 }
				end
			end,
			default_format_opts = { lsp_format = "fallback" },
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				astro = { "prettier" },
				yaml = { "yamlfmt" },
			},
		},
	},

	-- Completion
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = { { "L3MON4D3/LuaSnip", version = "2.*", opts = {} } },
		opts = {
			keymap = { preset = "default" }, -- <C-y> accept, <C-n>/<C-p> nav, <C-space> menu
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
			sources = { default = { "lsp", "path", "snippets" } },
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		},
	},

	-- mini.nvim: text objects, surround, statusline
	{
		"nvim-mini/mini.nvim",
		config = function()
			require("mini.ai").setup({
				mappings = { around_next = "aa", inside_next = "ii" },
				n_lines = 500,
			})
			require("mini.surround").setup() -- helix ms/md/mr parity via gsa/gsd/gsr

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"json5",
				"yaml",
				"toml",
				"rust",
				"python",
				"css",
			}
			require("nvim-treesitter").install(parsers)

			local function treesitter_try_attach(buf, language)
				if not vim.treesitter.language.add(language) then
					return
				end
				vim.treesitter.start(buf, language)
				if vim.treesitter.query.get(language, "indents") then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			local available_parsers = require("nvim-treesitter").get_available()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match
					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end
					local installed = require("nvim-treesitter").get_installed("parsers")
					if vim.tbl_contains(installed, language) then
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},

	-- Colorscheme: gruvbox-material, transparent, with CursorLine restored
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.g.gruvbox_material_transparent_background = 1

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	-- snacks.nvim: only the modules we use (no dashboard/notifier/words/scope/etc.)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			indent = { enabled = true, animate = { enabled = false } }, -- helix indent-guides parity
			input = { enabled = true },
			rename = { enabled = true },
			picker = {
				enabled = true,
				formatters = { file = { filename_first = true } },
			},
			explorer = { enabled = true },
		},
		keys = {
			{
				"<leader>f",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>;",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume last picker",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Doc symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "Workspace symbols",
			},
			{
				"<C-e>",
				function()
					Snacks.explorer()
				end,
				desc = "Explorer",
			},
		},
	},

	-- Top tab bar for open buffers (helix bufferline = "always" parity)
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VimEnter",
		opts = {
			options = {
				mode = "buffers",
				always_show_bufferline = true,
				diagnostics = "nvim_lsp",
				separator_style = "thin",
			},
		},
	},

	-- References + diagnostics list (Zed-style full buffer)
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", desc = "LSP references" },
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
			{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
			{
				"]r",
				function()
					require("trouble").next({ skip_groups = true, jump = true })
				end,
				desc = "Next reference",
			},
			{
				"[r",
				function()
					require("trouble").prev({ skip_groups = true, jump = true })
				end,
				desc = "Prev reference",
			},
		},
	},

	-- Rust tooling (rustaceanvim wraps rust-analyzer; crates.nvim adds Cargo.toml completion)
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							check = { command = "clippy" },
						},
					},
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = { crates = { enabled = true } },
			lsp = { enabled = true, actions = true, completion = true, hover = true },
		},
	},
}, {
	rocks = { enabled = false }, -- no plugins need luarocks; silences checkhealth warning
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
