local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local previewers = require "telescope.previewers"
local Job = require "plenary.job"

-- Create a new maker that won't preview binary files
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end,
  }):sync()
end

local action_layout = require "telescope.actions.layout"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    mappings = {
      i = {
        ["<C-h>"] = actions.which_key,
        ["<C-p>"] = action_layout.toggle_preview,
      },
      n = {
        ["<C-p>"] = action_layout.toggle_preview,
      },
    },
    no_ignore = true,
    prompt_prefix = "$ ",
  },

  extensions = {
    file_browser = {
      theme = "ivy",
    },

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

telescope.load_extension "file_browser"
telescope.load_extension "fzf"
telescope.load_extension "git_worktree"
telescope.load_extension "refactoring"
telescope.load_extension "ui-select"
