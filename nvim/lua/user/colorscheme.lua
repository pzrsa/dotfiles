vim.cmd([[
try
  colorscheme moonfly
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]])
