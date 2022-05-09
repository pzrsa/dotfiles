vim.cmd [[
try
  let g:vscode_style = "dark"
  colorscheme vscode
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
