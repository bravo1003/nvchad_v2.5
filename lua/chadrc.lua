---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.base46 = {
  theme = "tokyonight", -- default theme
  theme_toggle = { "tokyonight", "monekai" },
  changed_themes = {
    monekai = require "theme.monokai-pro",
  },

  hl_add = highlights.add,
  hl_override = highlights.override,
  transparency = false,

  integrations = {
    "notify",
    "rainbowdelimiters",
    "hop",
    "todo",
    "trouble",
  },
}

M.ui = {
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",
    selected_item_bg = "colored",
  },

  statusline = {
    theme = "default",
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
    order = {
      -- if disable nvimtree float, uncomment to add tree offset
      -- "treeOffset"
      "buffers",
      "tabs",
      "btns",
    },
  },

  nvdash = {
    load_on_startup = true,
    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

    buttons = {
      { "  Find File", "Spc s f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc s o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc s g", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc n t", "Telescope themes" },
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
      "prettier",

      -- c/cpp stuff
      "cpplint",
      "clangd",
      "clang-format",

      -- markdown
      "markdownlint",

      -- bash
      "shfmt",
    },
  },
}

return M
