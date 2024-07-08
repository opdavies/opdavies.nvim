local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    bash = { "shellcheck" },
    javascript = { { "prettierd", "prettier" } },
    just = { "just" },
    lua = { "stylua" },
    nix = { { "nixfmt" } },
    php = { { "php_cs_fixer", "phpcbf" } },
    terraform = { "terraform_fmt" },
    yaml = { "yamlfmt" },
  },

  format_on_save = {
    lsp_fallback = false,
    quiet = true,
  },
}
