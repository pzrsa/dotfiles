-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- colorschemes
	use("morhetz/gruvbox")
	use("Mofiqul/vscode.nvim")

	-- appearance
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")
	use("lewis6991/gitsigns.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- formatter
	use("jose-elias-alvarez/null-ls.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("L3MON4D3/LuaSnip") --snippet engine

	-- file navigating
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"Shougo/defx.nvim",
		run = ":UpdateRemotePlugins",
	})
	use("kristijanhusak/defx-git")
	use("kristijanhusak/defx-icons")

	-- utils
	use("moll/vim-bbye")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
end)
