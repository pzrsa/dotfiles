local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

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

	-- appearance
	use("morhetz/gruvbox")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")
	use("mhinz/vim-startify")
	use("lukas-reineke/indent-blankline.nvim")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- file navigating
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("kyazdani42/nvim-tree.lua")

	-- utils
	use("moll/vim-bbye")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("lewis6991/impatient.nvim")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("lewis6991/gitsigns.nvim")
	use("sbdchd/neoformat")
end)
