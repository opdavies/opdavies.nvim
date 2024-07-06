local telescope = require "telescope"

telescope.setup {
  defaults = {
    layout_config = { prompt_position = "top" },
    path_display = { truncate = 1 },
    prompt_prefix = "$ ",
    sorting_strategy = "ascending",
  },

  pickers = {
    lsp_references = {
      previewer = false,
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

telescope.load_extension "fzf"
telescope.load_extension "refactoring"
telescope.load_extension "ui-select"

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<space>fd", builtin.find_files)
vim.keymap.set("n", "<space>ft", builtin.git_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fg", builtin.live_grep)
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<space>gw", builtin.grep_string)
