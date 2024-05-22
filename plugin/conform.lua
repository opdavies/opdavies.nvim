local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    bash = { "shellcheck" },
    javascript = { { "prettierd", "prettier" } },
    just = { "just" },
    lua = { "stylua" },
    nix = { { "nixfmt", "alejandra" } },
    php = { { "php_cs_fixer", "phpcbf" } },
    terraform = { "terraform_fmt" },
    yaml = { "yamlfmt" },
  },
}

vim.keymap.set("n", "<leader>f", function()
  conform.format { lsp_fallback = true, async = false, timeout_ms = 500 }
end)
