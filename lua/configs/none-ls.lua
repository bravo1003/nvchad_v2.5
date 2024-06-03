local none_ls = require "null-ls"


local sources = {
  -- formatting
  none_ls.builtins.formatting.stylua,
  none_ls.builtins.formatting.clang_format,
  require "none-ls.formatting.jq",
  -- require "none-ls.diagnostics.cpplint",
}

none_ls.setup {
  sources = sources,
}
