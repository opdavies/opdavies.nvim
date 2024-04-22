require("obsidian").setup {
  workspaces = {
    {
      name = "wiki",
      path = "~/Code/gitlab.com/opdavies/wiki",
    },
  },

  new_notes_location = "0 - Inbox",
}

local nmap = require"opdavies.keymap".nmap

nmap { "<leader>on", "<cmd>ObsidianNew<cr>" }
nmap { "<leader>os", "<cmd>ObsidianSearch<cr>" }
