local M = {}

M.on_attach = function(_, bufnr)
  require("utils.lspkeyremaps").keymaps(bufnr)
end

return M
