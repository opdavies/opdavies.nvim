require("mini.ai").setup {}

require("mini.align").setup {}

require("mini.bracketed").setup {}

require("mini.hipatterns").setup {
  highlighters = {
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
  },
}

require("mini.move").setup {}

require("mini.operators").setup {}

require("mini.splitjoin").setup {}

require("mini.statusline").setup {}

require("mini.surround").setup {}