TelescopeMapArgs = TelescopeMapArgs or {}

local telescope_mapper = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('opdavies.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- Based on https://github.com/nvim-lua/kickstart.nvim
-- TODO: refactor telescope_mapper and add descriptions.
telescope_mapper("<leader>/", "current_buf") -- [/] Fuzzily search in current buffer
telescope_mapper("<leader><leader>", "buffers") -- [ ] Find existing buffers
telescope_mapper("<leader>s.", "oldfiles") -- '[S]earch Recent Files ("." for repeat)
telescope_mapper("<leader>sF", "find_all_files") -- [S]earch all [F]iles
telescope_mapper("<leader>sb", "file_browser") -- [S]earch using the File [B]rowser
telescope_mapper("<leader>sf", "find_files") -- [S]earch [F]iles
telescope_mapper("<leader>sg", "git_files") -- [S]earch [G]it Files
telescope_mapper("<leader>sh", "help_tags") -- [S]earch [H]elp
telescope_mapper("<leader>sl", "live_grep") -- [S]earch using [L]ive grep
telescope_mapper("<leader>sp", "grep_prompt") -- [S]earch using grep [P]rompt
telescope_mapper("<leader>st", "search_todos") -- [S]earch using grep [P]rompt

local builtin = require "telescope.builtin"
local telescope = require "telescope"

local nmap = require("opdavies.keymap").nmap

nmap {
  "<leader>s/",
  function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = "Live Grep in Open Files",
    }
  end,
  { desc = "[S]earch [/] in Open Files" },
}

nmap {
  "<leader>sw",
  function()
    local word = vim.fn.expand "<cword>"
    builtin.grep_string { search = word }
  end,
  { desc = "[S]earch for the current [W]ord" },
}

nmap {
  "<leader>sW",
  function()
    local word = vim.fn.expand "<cWORD>"
    builtin.grep_string { search = word }
  end,
  { desc = "[S]earch for the current [W]ord object" },
}

telescope_mapper("<leader>ds", "lsp_document_symbols")
telescope_mapper("<leader>dl", "diagnostics")

telescope_mapper("<leader>en", "edit_neovim")
telescope_mapper("<leader>ez", "edit_zsh")

return telescope_mapper
