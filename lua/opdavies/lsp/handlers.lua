local M = {}

M.definition = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
    local bufnr = ctx.bufnr
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

    local new_result = vim.tbl_filter(function(v)
      -- Remove any definitions within the nix store via the .direnv directory.
      if string.find(v.targetUri, ".direnv") then
        return false
      end

      -- Remove definitions within vendor-bin directory for PHP files.
      if ft == "php" then
        if string.find(v.targetUri, "vendor%-bin") then
          return false
        end
      end

      return true
    end, result)

    if #new_result > 0 then
      result = new_result
    end

    vim.lsp.handlers["textDocument/definition"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

return M
