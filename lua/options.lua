require "nvchad.options"

-- add yours here!

local g = vim.g
local opt = vim.opt

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Enable provider
local enable_providers = {
  "python3_provider",
}
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
local python3_host_prog = "/usr/bin/python3"
if vim.uv.os_uname().sysname == "Darwin" then
  python3_host_prog = "/opt/homebrew/bin/python3"
end
g.python3_host_prog = python3_host_prog
g.leetcode_browser = "firefox"
g.leetcode_solution_filetype = "cpp"

-- Enabled OSC52 if on ssh
local tty = vim.iter(vim.api.nvim_list_uis()):any(function(ui)
  return ui.chan == 1 and ui.stdout_tty
end)

if tty and os.getenv "SSH_TTY" then
  vim.g.clipboard = {
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
opt.foldenable = false
opt.clipboard = "unnamedplus"
-- cursorline support
opt.cursorlineopt = "both" -- to enable cursorline!
-- no swap files
opt.swapfile = false
opt.backup = false
-- undo hostory directoy
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true
-- no line warpping
opt.wrap = false
-- autoread reload changed file
opt.autoread = true
-- -- Set highlight on search
opt.hlsearch = false
opt.incsearch = true
-- Enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Decrease update time
opt.updatetime = 250
-- minimun scroll of screen
opt.scrolloff = 8
-- tab set up
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- menu and floating window blend
opt.pumblend = 10
opt.winblend = 10
opt.pumheight = 15
opt.colorcolumn = "100"
opt.cmdwinheight = 15

opt.isfname:append "@-@"

opt.autoread = true
vim.bo.autoread = true
g.code_action_menu_window_border = "rounded"

-- Set to true if you use nerfont
g.have_nerd_font = true
-- Undotree setup
g.undotree_WindowLayout = 1
-- g.undotree_SplitWidth = 30
g.undotree_SetFocusWhenToggle = 1
g.undotree_ShortIndicators = 1
g.undotree_DiffAutoOpen = 0

-- Better white space setup
g.better_whitespace_operator = ""
g.better_whitespace_enabled = 1
g.current_line_whitespace_disabled_hard = 1
g.better_whitespace_filetypes_blacklist = {
  "diff",
  "git",
  "gitcommit",
  "unite",
  "qf",
  "help",
  "markdown",
  "fugitive",
  "lazygit",
  "toggleterm",
  "terminal",
}

--- Setup neovide
if g.neovide then
  opt.pumblend = 25
  opt.winblend = 25

  if vim.uv.os_uname().sysname == "Darwin" then
    opt.guifont = "Fantasquesansm Nerd Font:h21:w1"
    g.neovide_input_macos_option_key_is_meta = "only_left"
  elseif vim.uv.os_uname().sysname == "Linux" then
    opt.guifont = "Fantasquesansm Nerd Font:h16"
    g.neovide_transparency = 0.85
    -- opt.linespace = -1
  end

  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_scroll_animation_length = 0.2
  -- g.neovide_cursor_vfx_particle_density = 20
  -- g.neovide_cursor_vfx_particle_lifetime = 2
  g.neovide_underline_stroke_scale = 2
end
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
