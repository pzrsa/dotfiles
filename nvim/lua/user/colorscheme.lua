require("vscode").setup({
  -- Enable transparent background
  transparent = true,
})
vim.cmd([[
try
  colorscheme vscode
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]])
