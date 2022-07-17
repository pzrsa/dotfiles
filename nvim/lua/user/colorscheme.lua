vim.cmd([[
try
  let g:gruvbox_contrast_dark = "hard"
  colorscheme gruvbox 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]])
