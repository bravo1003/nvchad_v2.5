local none_ls = require "null-ls"

local sources = {
  none_ls.builtins.diagnostics.cppcheck,
}

none_ls.setup {
  sources = sources,
}
