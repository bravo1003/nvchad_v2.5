local none_ls = require "null-ls"

local without_cpplint = {
  -- none_ls.builtins.completion.spell,
  -- formatting
  none_ls.builtins.formatting.stylua,
  none_ls.builtins.formatting.clang_format,
  require "none-ls.formatting.jq",
  -- require "none-ls-luacheck.diagnostics.luacheck",
}

local with_cpplint = {
  -- none_ls.builtins.completion.spell,
  -- formatting
  none_ls.builtins.formatting.stylua,
  none_ls.builtins.formatting.clang_format,
  require "none-ls.formatting.jq",
  -- require "none-ls-luacheck.diagnostics.luacheck",
  -- require "none-ls.diagnostics.cpplint",
}

local sources = with_cpplint
if vim.fn.stridx(vim.fn.getcwd(), "aml-comp") ~= -1 then
  sources = without_cpplint
end

none_ls.setup {
  sources = sources,
}
