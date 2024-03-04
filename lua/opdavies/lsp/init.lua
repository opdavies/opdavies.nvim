local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local nvim_status = require "lsp-status"

local imap = require("opdavies.keymap").imap
local nmap = require("opdavies.keymap").nmap

local telescope_mapper = require "opdavies.telescope.mappings"

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nmap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  imap(opts)
end

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities = require("cmp_nvim_lsp").default_capabilities(default_capabilities)

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local handlers = require "opdavies.lsp.handlers"

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  buf_inoremap { "<C-k>", vim.lsp.buf.signature_help }
  buf_nnoremap { "<leader>ca", vim.lsp.buf.code_action }
  buf_nnoremap { "<leader>d", vim.diagnostic.open_float }
  buf_nnoremap { "<leader>rn", vim.lsp.buf.rename }
  buf_nnoremap { "<leader>rr", "<cmd>LspRestart<cr>" }
  buf_nnoremap { "[d", vim.diagnostic.goto_prev }
  buf_nnoremap { "]d", vim.diagnostic.goto_next }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gd", handlers.definition }
  buf_nnoremap { "gi", vim.lsp.buf.implementation }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover }
  end

  telescope_mapper("<leader>dl", "diagnostics", nil, true)

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  -- filetype_attach[filetype](client)
end

require("neodev").setup {}

local servers = {
  ansiblels = {},
  bashls = {},
  cssls = {},
  gopls = {},
  grammarly = {},
  html = {},
  intelephense = {
    filetypes = { "php", "module", "test", "inc" },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },

        diagnostics = {
          globals = { "vim" },
        },

        runtime = { version = "LuaJIT" },
        telemetry = { enabled = false },
        workspace = { checkThirdParty = false },
      },
    },
  },
  rnix = {},
  tailwindcss = {
    filetypes = { "html", "html.twig", "javascript", "typescript", "vue" },

    init_options = {
      userLanguages = {
        ["html.twig"] = "html",
      },
    },
  },
  terraformls = {},
  tsserver = {},
  vuels = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}

local setup_server = function(server, config)
  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = default_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

vim.diagnostic.config {
  float = {
    source = true,
  },
  signs = true,
  underline = false,
  update_in_insert = false,
  virtual_text = { spacing = 2 },
}
