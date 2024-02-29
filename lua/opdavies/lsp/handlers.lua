local M = {}

M.definition = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
    local new_result = vim.tbl_filter(function(v)
      -- TODO: remove definitions within vendor-bin directory for PHP files?

      -- Remove any definitions within the nix store via the .direnv directory.
      return not string.find(v.targetUri, ".direnv")
    end, result)

    if #new_result > 0 then
      result = new_result
    end

    vim.lsp.handlers["textDocument/definition"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

return M
