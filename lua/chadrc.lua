---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.base46 = {
  theme = "catppuccin", -- default theme
  theme_toggle = { "catppuccin", "rosepine" },

  transparency = false,

  changed_themes = {
    catppuccin = {
      base_30 = {
        lavender = "#b4befe",
      },
    },
  },
  hl_add = highlights.add,
  hl_override = highlights.override,

  integrations = {
    "dap",
    "notify",
    "rainbowdelimiters",
    "hop",
    "todo",
    "trouble",
  },
}

M.ui = {
  cmp = {
    style = "default",
    selected_item_bg = "colored",
  },

  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    modules = {
      lsp = function()
        return "%#St_Lsp#" .. require("utils.lsp-statusline").lsp_overriden()
      end,
    },
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },

  nvdash = {
    load_on_startup = true,
    header = {
      "┏━┓━┏┓━━━━━━━━━━━━━━━━━━",
      "┃┃┗┓┃┃━━━━━━━━━━━━━━━━━━",
      "┃┏┓┗┛┃┏━━┓┏━━┓┏┓┏┓┏┓┏┓┏┓",
      "┃┃┗┓┃┃┃┏┓┃┃┏┓┃┃┗┛┃┣┫┃┗┛┃",
      "┃┃━┃┃┃┃┃━┫┃┗┛┃┗┓┏┛┃┃┃┃┃┃",
      "┗┛━┗━┛┗━━┛┗━━┛━┗┛━┗┛┗┻┻┛",
      "━━━━━━━━━━━━━━━━━━━━━━━━",
      "━━━━━━━━━━━━━━━━━━━━━━━━",
    },

    buttons = {
      { "  Find File", "Spc s f", "Telescope find_files theme=ivy" },
      { "󰈚  Recent Files", "Spc s o", "Telescope oldfiles theme=ivy" },
      { "󰈭  Find Word", "Spc s g", "Telescope live_grep theme=ivy" },
      { "  Bookmarks", "Spc m a", "Telescope marks theme=ivy" },
      { "  Themes", "Spc n t", "Telescope themes theme=ivy" },
      { "  Mappings", "Spc n c", "NvCheatsheet" },
    },
  },

  cheatsheet = { theme = "grid" }, -- simple/grid

  lsp = {
    signature = true,
    semantic_tokens = true,
  },

  mason = {
    cmd = true,
    pkgs = {
      -- lua stuff
      "lua-language-server",
      "stylua",
      "luacheck",

      -- web dev stuff
      -- "css-lsp",
      -- "html-lsp",
      -- "typescript-language-server",
      -- "deno",
      "prettier",
      "yaml-language-server",
      "yamllint",

      -- c/cpp stuff
      "cpplint",
      "clangd",
      "clang-format",
      "codelldb",

      -- rust
      "rust-analyzer",

      -- go
      -- "delve",
      -- "gopls",
      -- "golangci-lint",

      -- markdown
      "markdownlint",

      -- bash
      "shfmt",
    },
  },
}

return M
