local none_ls = require "null-ls"

local sources = {
  -- none_ls.builtins.completion.spell,
  -- formatting
  -- none_ls.builtins.formatting.stylua,
  -- none_ls.builtins.formatting.clang_format,
  -- require "none-ls-luacheck.diagnostics.luacheck",
  none_ls.builtins.diagnostics.cppcheck,
}

-- local sources = with_cpplint
-- if vim.fn.stridx(vim.fn.getcwd(), "aml-comp") ~= -1 then
--   sources = without_cpplint
-- end

none_ls.setup {
  sources = sources,
}
