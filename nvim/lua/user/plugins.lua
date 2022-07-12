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

	-- appearance
  use("Mofiqul/vscode.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("itchyny/lightline.vim")
  use("mengelbrecht/lightline-bufferline")

  -- lsp
  use ("neovim/nvim-lspconfig")
  use ("williamboman/nvim-lsp-installer")

  -- cmp
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-path')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')



	-- file navigating
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
	use({
		"Shougo/defx.nvim",
		run = ":UpdateRemoteuseins",
	})
	use("kristijanhusak/defx-git")
	use("kristijanhusak/defx-icons")

	-- utils
	use("moll/vim-bbye")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("lewis6991/impatient.nvim")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
end)
