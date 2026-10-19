---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
-- local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"
local utils = require "utils.nvchad_modules_override"

local options = {
  base46 = {
    theme = "catppuccin", -- default theme
    theme_toggle = { "catppuccin", "rosepine" },

    transparency = false,

    changed_themes = {
      catppuccin = {
        base_30 = {
          lavender = "#b4befe",
          light_grey = "#6c7086",
        },
      },
    },
    hl_add = highlights.add,
    hl_override = highlights.override,

    -- Only integrations base46 doesn't compile by default
    integrations = {
      "hop",
      "rainbowdelimiters",
      "render-markdown",
      "todo",
      "trouble",
    },
  },
  ui = {
    statusline = {
      theme = "vscode_colored",
      separator_style = "default",
      modules = {
        lsp = function()
          return "%#St_Lsp#" .. utils.lsp_overriden()
        end,
      },
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "buffers", "tabs", "btns" },
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
      { txt = "󱥚  Themes", keys = "Spc n t", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "Spc n c", cmd = "NvCheatsheet" },

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
  },

  mason = {
    cmd = true,
    pkgs = {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "typescript-language-server",
      "prettier",
      "yaml-language-server",
      "yamllint",

      -- python
      "jedi-language-server",

      -- toml
      "taplo",

      -- c/cpp stuff
      "clangd",
      "clang-format",

      -- rust: rust-analyzer comes from rustup so it matches the toolchain (see README)

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

  colorify = {
    mode = "bg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

return options
