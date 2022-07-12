local options = {
  scrolloff = 10,
  sidescrolloff = 10,
  showtabline = 2,
  smartindent = true,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  number = true,
  cursorline = true,
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
  colorcolumn = "80",
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  completeopt= "menu,menuone,noselect",
  guicursor = "i:block",
}

vim.cmd "let g:python3_host_prog  = '/opt/homebrew/bin/python3'"

for k, v in pairs(options) do
  vim.opt[k] = v
end
