local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local Job = require "plenary.job"
local previewers = require "telescope.previewers"

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
local lga_actions = require "telescope-live-grep-args.actions"

telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,

    file_ignore_patterns = {
      "%/contrib",
      "%/core",
      "%/libraries",
      ".direnv",
      ".git/",
      "composer.json.save",
      "composer.lock",
      "flake.lock",
      "node_modules",
      "package-lock.json",
      "pnpm-lock.yaml",
      "result",
      "vendor",
      "yarn.lock",
    },

    layout_config = { prompt_position = "top" },

    mappings = {
      i = {
        ["<C-d>"] = actions.delete_buffer,
        ["<C-h>"] = actions.which_key,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
      },
    },

    no_ignore = true,
    path_display = { truncate = 1 },
    preview = { hide_on_startup = true },
    prompt_prefix = "$ ",
    sorting_strategy = "ascending",
  },

  pickers = {
    find_files = {
      hidden = true,
    },

    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },

    lsp_references = {
      previewer = false,
    },
  },

  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt {},
          ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
        },
      },
    },

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "refactoring"
telescope.load_extension "ui-select"
