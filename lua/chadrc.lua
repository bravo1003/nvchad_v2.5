---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
-- local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

local options = {
  base46 = {
    theme = "tokyonight", -- default theme
    theme_toggle = { "tokyonight", "tokyonight" },
    changed_themes = {
      monekai = require "theme.monokai-pro",
    },
    transparency = false,

    hl_add = highlights.add,
    hl_override = highlights.override,

    integrations = {
      "avante",
      "blink",
      "dap",
      "devicons",
      "hop",
      "mini-icons",
      "notify",
      "rainbowdelimiters",
      "render-markdown",
      "telescope",
      "todo",
      "treesitter",
      "trouble",
      "whichkey",
    },
  },
  ui = {
    cmp = {
      style = "default",
      abbr_maxwidth = 60,
    },

    statusline = {
      theme = "default",
      separator_style = "block",
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
  },

  nvdash = {
    load_on_startup = true,
    header = {
      "                            ",
      "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
      "   ▄▀███▄     ▄██ █████▀    ",
      "   ██▄▀███▄   ███           ",
      "   ███  ▀███▄ ███           ",
      "   ███    ▀██ ███           ",
      "   ███      ▀ ███           ",
      "   ▀██ █████▄▀█▀▄██████▄    ",
      "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
      "                            ",
      "     Powered By  eovim    ",
      "                            ",
    },

    buttons = {
      { txt = "  Find File", keys = "Spc s f", cmd = "Telescope find_files" },
      { txt = "  Recent Files", keys = "Spc s o", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "Spc s g", cmd = "Telescope live_grep" },
      { txt = "󱥚  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashLazy",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
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
      "luacheck",

      -- web dev stuff
      "yaml-language-server",
      "yamllint",

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

  colorify = {
    mode = "bg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

return options
