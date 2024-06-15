---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.ui = {
  hl_add = highlights.add,
  hl_override = highlights.override,
  changed_themes = {
    catppuccin = {
      base_30 = {
        lavender = "#b4befe",
      },
    },
  },
  theme_toggle = { "catppuccin", "rosepine" },
  theme = "catppuccin", -- default theme
  transparency = false,

  extended_integrations = {
    "dap",
    "navic",
    "notify",
    "rainbowdelimiters",
    "hop",
    "todo",
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "flat_dark",
    selected_item_bg = "colored",
  },

  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    modules = {
      lsp = function()
        return "%#St_Lsp#" .. require("utils.lsp-statusline").lsp_overriden()
      end,
      lsp_msg = function()
        return ""
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
}

M.base46 = {
  integrations = {
    "dap",
    "navic",
    "notify",
    "rainbowdelimiters",
    "hop",
    "todo",
    "trouble",
  },
}
return M
