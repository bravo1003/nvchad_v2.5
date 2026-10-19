local on_attach = require("utils.lsputils").on_attach

-- if you just want default config for the servers then put them in a table
local servers = { "ts_ls", "taplo", "yamlls", "jedi_language_server" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    on_attach(_, args.buf)
  end,
})

-- blink.cmp lazy-loads on InsertEnter, after servers have started.
-- Load it here so every server gets blink's completion capabilities.
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

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
vim.lsp.config("lua_ls", {
  settings = lua_lsp_settings,
})
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

-- Override only cmd; filetypes, root markers and the LspClangd* commands come from nvim-lspconfig
vim.lsp.config("clangd", {
  cmd = cmd,
})
vim.lsp.enable "clangd"

-- Setup Gopls server
vim.lsp.config("gopls", {
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
