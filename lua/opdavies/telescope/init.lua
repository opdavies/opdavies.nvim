SHOULD_RELOAD_TELESCOPE = true

local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    RELOAD "plenary"
    RELOAD "telescope"
    RELOAD "opdavies.telescope.setup"
  end
end

local themes = require "telescope.themes"

local M = {}

function M.current_buf()
  local opts = {
    sorting_strategy = "ascending",
    previewer = false,
  }

  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

M.diagnostics = function()
  local theme = require("telescope.themes").get_dropdown {
    previewer = false,
  }

  require("telescope.builtin").diagnostics(theme)
end

function M.lsp_document_symbols()
  local theme = require("telescope.themes").get_dropdown {
    previewer = false,
  }

  require("telescope.builtin").lsp_document_symbols(theme)
end

function M.edit_neovim()
  local opts = {
    cwd = "~/Code/github.com/opdavies/dotfiles/config/neovim",
    find_command = { "rg", "--no-ignore", "--files", "--follow" },
    path_display = { "shorten" },
    prompt_title = "~ dotfiles ~",
    no_ignore = true,

    layout_strategy = "flex",
    layout_config = {
      height = 0.8,
      prompt_position = "top",
      width = 0.9,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }

  require("telescope.builtin").find_files(opts)
end

function M.edit_zsh()
  local opts = {
    cwd = "~/.config/zsh",
    path_display = { "shorten" },
    prompt_title = "~ zsh ~",
    no_ignore = true,

    layout_strategy = "flex",
    layout_config = {
      height = 0.8,
      prompt_position = "top",
      width = 0.9,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }

  require("telescope.builtin").find_files(opts)
end

function M.find_all_files()
  local opts = {
    file_ignore_patterns = { ".direnv", ".git" },
    no_ignore = true,
    prompt_title = "All Files",
  }

  require("telescope.builtin").find_files(opts)
end

function M.git_files()
  local opts = {
    hidden = true,
    no_ignore = true,
  }

  require("telescope.builtin").git_files(opts)
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

function M.live_grep()
  require("telescope").extensions.live_grep_args.live_grep_args {
    file_ignore_patterns = { ".git/" },
    hidden = true,
    no_ignore = true,
    sorting_strategy = "ascending",
  }
end

function M.oldfiles()
  local opts = {
    prompt_title = "History",
  }

  require("telescope").extensions.frecency.frecency(opts)
end

function M.search_todos()
  local opts = {
    search = "TODO",
    search_dirs = {
      "app",
      "docroot/modules/custom",
      "docroot/themes/custom",
      "src",
      "web/modules/custom",
      "web/themes/custom",
    },
    prompt_title = "TODOs",
  }

  require("telescope.builtin").grep_string(opts)
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
