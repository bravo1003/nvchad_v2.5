local M = {}

local version = vim.version().minor
-- Do not include null-ls in LSP statusline

M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.lsp_overriden = function()
  if rawget(vim, "lsp") and version >= 10 then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[M.stbufnr()] and client.name ~= "null-ls" and client.name ~= "copilot" then
        return (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
      end
    end
  end

  return ""
end


M.getSnackExplorerWidth = function()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "snacks_picker_list" then
      return vim.api.nvim_win_get_width(win)
    end
  end
  return 0
end

return M
