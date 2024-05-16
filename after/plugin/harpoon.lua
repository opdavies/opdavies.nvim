require("harpoon").setup()

local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

vim.keymap.set("n", "<M-h><M-l>", ui.toggle_quick_menu)
vim.keymap.set("n", "<M-h><M-m>", mark.add_file)

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hc", mark.clear_all)
vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hr", mark.rm_file)

for i = 1, 5 do
  vim.keymap.set("n", string.format("<space>%s", i), function()
    ui.nav_file(i)
  end)
end
