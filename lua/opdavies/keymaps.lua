local keymap = require "opdavies.keymap"

local imap = keymap.imap
local nmap = keymap.nmap
local vmap = keymap.vmap
local xmap = keymap.xmap

nmap { "<Leader>so", ":call opdavies#save_and_exec()<CR>" }

-- Format paragraphs to an 80 character line length.
nmap { "<Leader>g", "gqap" }
xmap { "<Leader>g", "gqa" }

-- Make the current file executable
nmap { "<Leader>x", ":!chmod +x %<Cr>" }

-- Yank from the current column to the end of the line
nmap { "Y", "yg$" }

-- Keep things centred
nmap { "n", "nzzzv" }
nmap { "N", "Nzzzv" }

-- Disable arrow keys
vmap { "<down>", "<nop>" }
vmap { "<left>", "<nop>" }
vmap { "<right>", "<nop>" }
vmap { "<up>", "<nop>" }

nmap { "<C-f>", ":silent !tmux neww t<CR>", { noremap = true, silent = true } }

-- Easy insertion of a trailing ; or , from insert mode
imap { ",,", "<Esc>A,<Esc>" }
imap { ";;", "<Esc>A;<Esc>" }

nmap { "ga", "<Plug>(EasyAlign)" }
xmap { "ga", "<Plug>(EasyAlign)" }

-- Focus on the current buffer.
nmap { "<leader>-", ":wincmd _<cr>:wincmd |<cr>", { noremap = true, silent = true } }

-- Automatically resize buffers.
nmap { "<leader>=", ":wincmd =<cr>", { noremap = true, silent = true } }

-- Move line(s) up and down.
local opts = { noremap = true, silent = true }
imap { "<M-j>", "<Esc>:m .+1<CR>==gi", opts }
imap { "<M-k>", "<Esc>:m .-2<CR>==gi", opts }
nmap { "<M-j>", ":m .+1<CR>==", opts }
nmap { "<M-k>", ":m .-2<CR>==", opts }
vmap { "<M-j>", ":m '>+1<CR>gv=gv", opts }
vmap { "<M-k>", ":m '<-2<CR>gv=gv", opts }

-- Re-centre when navigating.
nmap { "#", "#zz", opts }
nmap { "%", "%zz", opts }
nmap { "*", "*zz", opts }
nmap { "<C-d>", "<C-d>zz", opts }
nmap { "<C-i>", "<C-i>zz", opts }
nmap { "<C-o>", "<C-o>zz", opts }
nmap { "<C-u>", "<C-u>zz", opts }
nmap { "G", "Gzz", opts }
nmap { "N", "Nzz", opts }
nmap { "gg", "ggzz", opts }
nmap { "n", "Nzz", opts }
nmap { "{", "{zz", opts }
nmap { "}", "}zz", opts }

-- Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
vim.cmd [[ nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}() ]]

-- Quicker macro playback.
nmap { "Q", "@qj" }
xmap { "Q", ":norm @q<CR>" }
