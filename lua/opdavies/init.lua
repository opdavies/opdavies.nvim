pcall("require", impatient)

require "opdavies.globals"

require "opdavies.options"

require "opdavies.lsp"

require "opdavies.telescope.setup"
require "opdavies.telescope.mappings"

vim.api.nvim_create_user_command("GoToFile", function()
  require("opdavies.telescope").git_files()
end, {})

vim.keymap.set("v", "Q", "<nop>")

vim.keymap.set("v", "J", ":m '>+1<CR>gvrgv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
