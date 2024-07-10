vim.g.mapleader = " "
vim.g.snippets = "luasnip"

local settings = {
  autoindent = true,
  backup = false,
  breakindent = true,
  colorcolumn = "80",
  expandtab = true,
  foldlevel = 1,
  foldlevelstart = 99,
  foldmethod = "indent",
  formatoptions = "clqjp",
  hidden = false,
  hlsearch = false,
  inccommand = "split",
  laststatus = 3,
  linebreak = true,
  list = true,
  mouse = "",
  number = true,
  pumblend = 10,
  pumheight = 10,
  relativenumber = true,
  scrolloff = 5,
  shiftwidth = 2,
  showmode = false,
  signcolumn = "yes:1",
  smartindent = true,
  softtabstop = 2,
  spellfile = "/home/opdavies/Code/opdavies.nvim/spell/en.utf-8.add",
  swapfile = false,
  syntax = "on",
  tabstop = 2,
  termguicolors = true,
  textwidth = 0,
  undodir = os.getenv "HOME" .. "/.vim/undodir",
  undofile = true,
  updatetime = 1000,
  wrap = false,
}

for key, value in pairs(settings) do
  vim.o[key] = value
end

vim.opt.backupdir:remove "." -- keep backups out of the current directory
vim.opt.clipboard:append "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.listchars:append {
  trail = "·",
}

vim.cmd [[
  autocmd FileType gitcommit highlight ColorColumn ctermbg=8
  autocmd FileType gitcommit setlocal colorcolumn=50,72
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal textwidth=72

  filetype indent on
  filetype on
  filetype plugin on
]]
