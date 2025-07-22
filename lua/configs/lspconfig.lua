local on_init = require("utils.lsputils").on_init
local on_attach = require("utils.lsputils").on_attach

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "taplo", "yamlls", "jedi_language_server" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    on_attach(_, args.buf)
  end,
})
vim.lsp.config("*", { on_init = on_init })
vim.lsp.enable(servers)

-- Setup lua language server
local lua_lsp_settings = {
  Lua = {
    runtime = { version = "LuaJIT" },
    workspace = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
    },
  },
}
vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
vim.lsp.enable "lua_ls"

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

-- if vim.fn.stridx(vim.fn.getcwd(), "work/tvsdk") >= 0 then
--   table.insert(cmd, "--compile-commands-dir=/home/jliu/work/chromium/src/out_gn_aml-t962d4/Release/")
-- end

if vim.uv.os_uname().sysname == "Linux" then
  table.insert(cmd, "--malloc-trim")
end

vim.lsp.config("clang", {
  cmd = cmd,
  filetypes = { "c",  "cpp", "objc", "objcpp", "cuda" },
  root_markers = { "compile_commands.json", ".git" },
})
vim.lsp.enable "clang"

-- Setup Gopls server
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
vim.lsp.enable "gopls"

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "single"

  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
