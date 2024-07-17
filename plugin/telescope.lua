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

local search_all_files = function()
  builtin.find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end

vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<space>fb", builtin.buffers)
vim.keymap.set("n", "<space>fd", builtin.find_files)
vim.keymap.set("n", "<space>fg", builtin.live_grep)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fi", search_all_files)
vim.keymap.set("n", "<space>fk", builtin.keymaps)
vim.keymap.set("n", "<space>ft", builtin.git_files)

vim.keymap.set("n", "<space>ds", builtin.lsp_document_symbols)

vim.keymap.set("n", "<space>gw", builtin.grep_string)
