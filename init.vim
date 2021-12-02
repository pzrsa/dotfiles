call plug#begin(stdpath('data') . '/plugged')

  Plug 'chun-yang/auto-pairs'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}


" Initialize plugin system
call plug#end()

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show current position
set ruler
set number

" Use spaces instead of tabs
set expandtab

set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set autoindent " Auto indent
set smartindent " Smart indent

" Always show the status line
set laststatus=2

" Always show tab bar
set showtabline=2

lua require('lspconfig').tsserver.setup{}
