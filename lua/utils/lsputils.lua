local M = {}

local navic = require "nvim-navic"
local illuminate = require "illuminate"
local map = vim.keymap.set
local conf = require("nvconfig").ui.lsp

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  illuminate.on_attach(client)

  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end

  -- LSP related
  map("n", "gr", "<cmd> Telescope lsp_references theme=ivy <cr>", { desc = "Go to references" })
  map("n", "gd", "<cmd> Telescope lsp_definitions theme=ivy <cr>", { desc = "Go to definition" })
  map("n", "gI", "<cmd> Telescope lsp_implementations theme=ivy <cr>", { desc = "Go to implementation" })
  map("n", "<leader>lr", function()
    vim.lsp.buf.declaration()
  end, { desc = "Go to declaration" })
end

-- disable semantic tokens
M.on_init = function(client, _)
  if not conf.semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return M
