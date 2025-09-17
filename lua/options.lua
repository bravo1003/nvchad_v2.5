require "nvchad.options"

local g = vim.g
local o = vim.o

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set to true if you use nerfont
g.have_nerd_font = true
-- Enable provider
-- local enable_providers = {
--   "python3_provider",
-- }
-- for _, plugin in pairs(enable_providers) do
--   vim.g["loaded_" .. plugin] = nil
--   vim.cmd("runtime " .. plugin)
-- end
-- local python3_host_prog = "/usr/bin/python3"
-- if vim.uv.os_uname().sysname == "Darwin" then
--   python3_host_prog = "/opt/homebrew/bin/python3"
-- end
-- g.python3_host_prog = python3_host_prog

o.clipboard = "unnamedplus"

-- Enabled OSC52 if on ssh
local tty = vim.iter(vim.api.nvim_list_uis()):any(function(ui)
  return ui.chan == 1 and ui.stdout_tty
end)

if tty and os.getenv "SSH_TTY" then
  o.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste "+",
      ["*"] = require("vim.ui.clipboard.osc52").paste "*",
    },
  }
end

o.foldenable = false
-- no swap files
o.swapfile = false
o.backup = false
-- no line warpping
o.wrap = true
-- autoread reload changed file
o.autoread = true
-- Set highlight on search
o.hlsearch = false
o.incsearch = true
-- Enable break indent
o.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true
-- Decrease update time
o.updatetime = 250
-- minimum scroll of screen
o.scrolloff = 8
-- tab set up
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
-- o.colorcolumn = "100"

vim.opt.isfname:append "@-@"

o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both" -- to enable cursorline!
o.laststatus = 3

-- undo history directory
o.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.undofile = true

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Do not map tmux navigator since C-\(toggleterm) would be overwritten
g.tmux_navigator_no_mappings = 1

-- Catppuccin colorscheme
local base16 = require("base46").get_theme_tb "base_16"
local colors = require("base46").get_theme_tb "base_30"
g.terminal_color_0 = "#6c7086"
g.terminal_color_8 = "#7f849c"
g.terminal_color_0 = base16.base04
g.terminal_color_8 = colors.grey
g.terminal_color_1 = colors.red
g.terminal_color_9 = colors.red
g.terminal_color_2 = colors.green
g.terminal_color_10 = colors.green
g.terminal_color_3 = colors.yellow
g.terminal_color_11 = colors.yellow
g.terminal_color_4 = colors.blue
g.terminal_color_12 = colors.blue
g.terminal_color_5 = colors.pink
g.terminal_color_13 = colors.pink
g.terminal_color_6 = colors.teal
g.terminal_color_14 = colors.teal
g.terminal_color_7 = colors.lavender
g.terminal_color_15 = colors.lavender

--- Setup neovide
if g.neovide then
  if vim.uv.os_uname().sysname == "Darwin" then
    -- o.guifont = "JetBrainsMono Nerd Font Mono:h21:w1"
    g.neovide_input_macos_option_key_is_meta = "only_left"
    g.neovide_underline_stroke_scale = 1.5
    g.neovide_opacity = 0.8
    g.neovide_window_blurred = true
    g.neovide_floating_blur_amount_x = 30.0
    g.neovide_floating_blur_amount_y = 30.0
  elseif vim.uv.os_uname().sysname == "Linux" then
    g.neovide_padding_top = 3
    -- g.neovide_padding_bottom = 2
    -- g.neovide_padding_right = 5
    g.neovide_padding_left = 5
    g.neovide_underline_stroke_scale = 1.7
    g.neovide_opacity = 0.85
    g.neovide_floating_blur_amount_x = 4.0
    g.neovide_floating_blur_amount_y = 4.0
  end

  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_scroll_animation_length = 0.2
  -- g.neovide_cursor_vfx_particle_density = 20
  -- g.neovide_cursor_vfx_particle_lifetime = 2
end
