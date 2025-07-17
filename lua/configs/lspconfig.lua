local on_attach = require("utils.lsputils").on_attach
local on_init = require("utils.lsputils").on_init
local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require "lspconfig"
local lsputils = require "lspconfig.util"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "taplo", "yamlls", "jedi_language_server" }

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
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
}

-- Setup Clangd server
local cmd = {
  "clangd",
  "--background-index",
  "-j=4",
  -- "--all-scopes-completion",
  "--clang-tidy",
  "--header-insertion=never",
  "--completion-style=detailed",
  "--function-arg-placeholders",
  "--fallback-style=llvm",
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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "single"

  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
