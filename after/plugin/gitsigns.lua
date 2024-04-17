local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status_ok then
  return
end

gitsigns.setup {
  linehl = false,
  numhl = true,
}

local map = require("opdavies.keymap").map
local nmap = require("opdavies.keymap").nmap
local vmap = require("opdavies.keymap").vmap

nmap { "[h", "<cmd>Gitsigns prev_hunk<CR>" }
nmap { "]h", "<cmd>Gitsigns next_hunk<CR>" }

nmap { "<leader>hR", gitsigns.reset_buffer }
nmap { "<leader>hS", gitsigns.stage_buffer }
nmap { "<leader>hb", gitsigns.blame_line }
nmap { "<leader>hp", gitsigns.preview_hunk }
nmap { "<leader>hr", gitsigns.reset_hunk }
nmap { "<leader>hs", gitsigns.stage_hunk }
nmap { "<leader>hu", gitsigns.undo_stage_hunk }

vmap {
  "<leader>hr",
  function()
    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end,
}
vmap {
  "<leader>hs",
  function()
    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end,
}

-- Text object.
map { { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>" }
