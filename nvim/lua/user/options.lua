local options = {
	scrolloff = 10,
	sidescrolloff = 10,
	showtabline = 2,
	smartindent = true,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	background = "dark",
	number = true,
	cursorline = true,
	smartcase = true,
	ignorecase = true,
	clipboard = "unnamedplus",
	hlsearch = false,
	wrap = false,
	swapfile = false,
	hidden = true,
	backup = false,
	termguicolors = true,
	lazyredraw = true,
	incsearch = true,
	showmode = false,
	mouse = "a",
	updatetime = 50,
	shortmess = "c",
	undofile = true,
	pumheight = 12,
	cmdheight = 2,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	completeopt = "menu,menuone,noselect",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[
colorscheme noirbuddy

cabb w wa

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap linebreak
augroup END
]])
