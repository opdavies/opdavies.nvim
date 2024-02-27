require("harpoon").setup()

local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

local nmap = require("opdavies.keymap").nmap

nmap { "<M-h><M-l>", ui.toggle_quick_menu }
nmap { "<M-h><M-m>", mark.add_file }

nmap { "<leader>ha", mark.add_file }
nmap { "<leader>hc", mark.clear_all }
nmap { "<leader>ho", ui.toggle_quick_menu }
nmap { "<leader>hr", mark.rm_file }

for i = 1, 5 do
  nmap {
    string.format("<space>%s", i),
    function()
      ui.nav_file(i)
    end,
  }
end
