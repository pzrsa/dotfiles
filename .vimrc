call plug#begin(stdpath('data') . '/plugged')

  Plug 'chun-yang/auto-pairs'
  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'preservim/nerdtree'
  Plug 'tomasiser/vim-code-dark'


" Initialize plugin system
call plug#end()

" vscode dark colorscheme
colorscheme codedark

" prettier on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
