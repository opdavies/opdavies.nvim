local nmap = require "opdavies.keymap".nmap

nmap { "<leader>lg", "<cmd>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<cr>" }
nmap { "<leader>tt", "<cmd>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<cr>" }
