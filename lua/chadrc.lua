---@diagnostic disable: missing-fields
-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
-- local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

local options = {
  base46 = {
    theme = "monekai", -- default theme
    theme_toggle = { "monekai", "rosepine" },
    changed_themes = {
      monekai = require "theme.monokai-pro",
    },

    transparency = false,

    hl_add = highlights.add,
    hl_override = highlights.override,

    integrations = {
      "notify",
      "rainbowdelimiters",
      "hop",
      "todo",
      "trouble",
    },
  },
  ui = {
    cmp = {
      style = "default",
      abbr_maxwidth = 60,
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
      { txt = "  Find File", keys = "Spc s f", cmd = "Telescope find_files theme=ivy" },
      { txt = "  Recent Files", keys = "Spc s o", cmd = "Telescope oldfiles theme=ivy" },
      { txt = "󰈭  Find Word", keys = "Spc s g", cmd = "Telescope live_grep theme=ivy" },
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

  colorify = {
    mode = "bg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

return options
