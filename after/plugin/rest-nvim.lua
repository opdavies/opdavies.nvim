require("rest-nvim").setup()

vim.keymap.set("n", "<leader>rr", "<plug>RestNvim<cr>")
vim.keymap.set("n", "<leader>rp", "<plug>RestNvimPreview<cr>")
vim.keymap.set("n", "<leader>rl", "<plug>RestNvimLast<cr>")
