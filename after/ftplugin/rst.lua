local opt = vim.opt

opt.wrap = true

local cmp = require "cmp"
local sources = cmp.get_config().sources

table.insert(sources, { name = "path" })

cmp.setup.buffer { sources = sources }
