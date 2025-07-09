local M = {}
local map = vim.keymap.set
local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

M.keymaps = function()
  -- LSP related
  -- map("n", "gd", "<cmd> Telescope lsp_definitions <cr>", opts "Go to definition")
  -- map("n", "gr", "<cmd> Telescope lsp_references <cr>", opts "Go to references")
  map("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts "Go to definition")
  map("n", "gr", function()
    vim.lsp.buf.references()
  end, opts "Go to references")
  map("n", "<leader>lw", function()
    vim.lsp.buf.workspace_symbol()
  end, opts "List workspace symbols")
  map("n", "gI", "<cmd> Telescope lsp_implementations <cr>", opts "Go to implementation")
  map("n", "gD", function()
    vim.lsp.buf.declaration()
  end, opts "Go to declaration")
  -- map("n", "<leader>lf", function()
  --   vim.lsp.buf.format { async = true }
  -- end, opts "LSP Format")
  map("n", "<leader>lr", function()
    require "nvchad.lsp.renamer"()
  end, opts "LSP Rename")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Show signature help")
  map("i", "<C-s>", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, opts "Toggle Inlay Hint")
end

return M
