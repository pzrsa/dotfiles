-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return require('packer').startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  -- colorschemes
  use "morhetz/gruvbox"
  use "Mofiqul/vscode.nvim"

  -- appearance
  use "kyazdani42/nvim-web-devicons"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/bufferline.nvim"

  -- utils
  use "moll/vim-bbye"
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"
end)
