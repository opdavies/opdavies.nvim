TelescopeMapArgs = TelescopeMapArgs or {}

local telescope = require "telescope"

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

telescope_mapper("<leader>fb", "buffers")
telescope_mapper("<leader>fd", "find_files")
telescope_mapper("<leader>fe", "file_browser")
telescope_mapper("<leader>ff", "current_buf")
telescope_mapper("<leader>fg", "git_files")
telescope_mapper("<leader>fh", "help_tags")
telescope_mapper("<leader>fl", "live_grep")
telescope_mapper("<leader>fo", "oldfiles")

telescope_mapper("<leader>ds", "lsp_document_symbols")
telescope_mapper("<leader>dl", "diagnostics")

telescope_mapper("<leader>en", "edit_neovim")
telescope_mapper("<leader>ez", "edit_zsh")

local nmap = require("opdavies.keymap").nmap

nmap { "<leader>gm", telescope.extensions.git_worktree.create_git_worktree }
nmap { "<leader>gw", telescope.extensions.git_worktree.git_worktrees }

return telescope_mapper
