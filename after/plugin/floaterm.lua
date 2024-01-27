-- Based on https://github.com/ALT-F4-LLC/thealtf4stream.nvim/blob/main/lua/TheAltF4Stream/floaterm.lua.

local nmap = require "opdavies.keymap".nmap

nmap { "<leader>ld", "<cmd>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazydocker<cr>" }
nmap { "<leader>lg", "<cmd>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<cr>" }
nmap { "<leader>nn", "<cmd>FloatermNew --autoclose=2 --height=0.75 --width=0.75 nnn -Hde<cr>" }
nmap { "<leader>tt", "<cmd>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<cr>" }
