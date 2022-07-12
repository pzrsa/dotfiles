vim.cmd([[
try
  let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
  colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
