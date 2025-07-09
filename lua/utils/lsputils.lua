local M = {}

local conf = require "nvconfig"

-- disable semantic tokens
M.on_init = function(client, _)
  if not conf.lsp.semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.on_attach = function(client, bufnr)
  require("utils.lspkeyremaps").keymaps()
end

return M
