local on_attach = require("utils.lsputils").on_attach
local on_init = require("utils.lsputils").on_init
local capabilities = require("utils.lsputils").capabilities
local lspconfig = require "lspconfig"
local lsputils = require "lspconfig.util"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "taplo", "jedi_language_server" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup lua server
lspconfig.lua_ls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- Setup Clangd server
local cmd = {
  "clangd",
  "--background-index",
  "-j=4",
  "--all-scopes-completion",
  -- "--completion-style=detailed",
  "--header-insertion=never",
  "--clang-tidy",
  "--offset-encoding=utf-16",
  "--pch-storage=disk",
}

if vim.uv.os_uname().sysname == "Linux" then
  table.insert(cmd, "--malloc-trim")
end

lspconfig.clangd.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = cmd,
  root_dir = lsputils.root_pattern("compile_commands.json", ".git"),
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})
