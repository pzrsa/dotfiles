vim.cmd [[
try
  let ayucolor="dark"   " for dark version of theme
  colorscheme ayu
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
