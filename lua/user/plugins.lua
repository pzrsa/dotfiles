local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'

  -- Colorscheme
  Plug "lunarvim/darkplus.nvim"


vim.call('plug#end')

