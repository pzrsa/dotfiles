call plug#begin('~/.local/share/nvim/plugged')
  
  Plug 'jiangmiao/auto-pairs'

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

set ai " Auto indent
set si " Smart indent

" Always show the status line
set laststatus=2
