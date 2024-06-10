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
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    conform.format {
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    }
  end,
})
