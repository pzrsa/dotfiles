require("vscode").setup({
	transparent = true,
})
vim.cmd([[
try
  " let g:gruvbox_contrast_dark = "hard"
  " colorscheme gruvbox 
  colorscheme vscode
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]])
