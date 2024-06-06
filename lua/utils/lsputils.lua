local M = {}

local navic = require "nvim-navic"
local illuminate = require "illuminate"
local map = vim.keymap.set
local conf = require("nvconfig").ui.lsp
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

-- disable semantic tokens
M.on_init = function(client, _)
  if not conf.semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  illuminate.on_attach(client)

  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end

  -- LSP related
  map("n", "gr", "<cmd> Telescope lsp_references theme=ivy <cr>", opts "Go to references")
  map("n", "gd", "<cmd> Telescope lsp_definitions theme=ivy <cr>", opts "Go to definition")
  map("n", "gI", "<cmd> Telescope lsp_implementations theme=ivy <cr>", opts "Go to implementation")
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
  map({ "n", "v" }, "<leader>la", function()
    require("actions-preview").code_actions()
  end, opts "LSP Code Action")
  map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, opts "Toggle Inlay Hint")
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

vim.g.rustaceanvim.server.on_attach = function()
  -- LSP related
  map("n", "gr", "<cmd> Telescope lsp_references theme=ivy <cr>", opts "Go to references")
  map("n", "gd", "<cmd> Telescope lsp_definitions theme=ivy <cr>", opts "Go to definition")
  map("n", "gI", "<cmd> Telescope lsp_implementations theme=ivy <cr>", opts "Go to implementation")
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
  map({ "n", "v" }, "<leader>la", function()
    require("actions-preview").code_actions()
  end, opts "LSP Code Action")
  map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, opts "Toggle Inlay Hint")
end

return M
