require "nvchad.options"

local g = vim.g
local opt = vim.opt

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.foldenable = false
opt.clipboard = "unnamedplus"
-- no swap files
opt.swapfile = false
opt.backup = false
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
opt.pumblend = 5
opt.winblend = 5
opt.pumheight = 15
opt.cmdwinheight = 15

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both" -- to enable cursorline!

opt.isfname:append "@-@"

-- Set to true if you use nerfont
g.have_nerd_font = true

-- undo hostory directoy
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true

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
