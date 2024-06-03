local none_ls = require "null-ls"

none_ls.setup {
  sources = {
    none_ls.builtins.completion.spell,

    -- formatting
    none_ls.builtins.formatting.stylua,
    none_ls.builtins.formatting.clang_format,
    require("none-ls.formatting.jq"),
    require("none-ls-luacheck.diagnostics.luacheck"),

    -- diagnostics
    require("none-ls.diagnostics.cpplint"),
  },
}
