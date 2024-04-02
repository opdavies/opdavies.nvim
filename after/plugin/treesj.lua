local tsj = require "treesj"

tsj.setup {
  use_default_keymaps = false,
}

local nmap = require "opdavies.keymap".nmap

nmap { "gJ", tsj.join }
nmap { "gS", tsj.split }
