require "nvchad.options"

local g = vim.g
local opt = vim.opt

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

opt.clipboard = "unnamedplus"
-- Enabled OSC52 if on ssh
local tty = vim.iter(vim.api.nvim_list_uis()):any(function(ui)
  return ui.chan == 1 and ui.stdout_tty
end)

if tty and os.getenv "SSH_TTY" then
  opt.clipboard = {
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
-- no swap files
opt.swapfile = false
opt.backup = false
-- no line warpping
opt.wrap = true
-- autoread reload changed file
opt.autoread = true
-- Set highlight on search
opt.hlsearch = false
opt.incsearch = true
-- Enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Decrease update time
opt.updatetime = 250
-- minimum scroll of screen
opt.scrolloff = 8
-- tab set up
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- opt.colorcolumn = "100"
opt.cmdwinheight = 15

opt.isfname:append "@-@"

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both" -- to enable cursorline!
opt.laststatus = 3

-- undo history directory
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Do not map tmux navigator since C-\(toggleterm) would be overwritten
g.tmux_navigator_no_mappings = 1
