local ls = require "luasnip"

local snippet = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local shortcut = function(val)
  if type(val) == "string" then
    return { t { val }, i(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t { v }
      end
    end
  end

  return val
end

local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

local snippets = {}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/opdavies/snippets/ft/*.lua", true)) do
  local ft = vim.fn.fnamemodify(ft_path, ":t:r")
  snippets[ft] = make(loadfile(ft_path)())

  ls.add_snippets(ft, snippets[ft])
end

ls.add_snippets("js", snippets.javascript)
ls.add_snippets("typescript", snippets.javascript)
ls.add_snippets("vue", snippets.javascript)

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
  enable_autosnippets = true,
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

-- Expand the current item or just to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Jump backwards.
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- Select within a list of options.
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set(
  "n",
  "<leader><leader>s",
  "<cmd>source ~/Code/github.com/opdavies/dotfiles/config/neovim/after/plugin/luasnip.lua<CR>"
)
