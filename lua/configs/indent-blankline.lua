local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

local hooks = require "ibl.hooks"
require("ibl").setup {
  indent = {
    char = "▎",
    highlight = "IblChar",
    smart_indent_cap = true,
  },
  scope = {
    char = "▎",
    highlight = highlight,
  },
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "lazy",
      "lspinfo",
      "mason",
      "nvdash",
      "nvcheatsheet",
      "noice",
      "NvimTree",
    },
  },
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
