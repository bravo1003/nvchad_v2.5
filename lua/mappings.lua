require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del
-- Disabled

-- Default Telescope binding
del("n", "<leader>b")
del("n", "<leader>fa")
del("n", "<leader>fb")
del("n", "<leader>ff")
del("n", "<leader>fh")
del("n", "<leader>fm")
del("n", "<leader>fo")
del("n", "<leader>fw")
del("n", "<leader>fz")
del("n", "<leader>ma")
del("n", "<leader>gc")
del("n", "<leader>gt")
del("n", "<leader>ds")
del("n", "<leader>ch")
del("n", "<leader>cm")
del("n", "<leader>pt")
del("n", "<leader>th")

-- Terminal
del("t", "<C-x>")
del("n", "<leader>h")
del("n", "<leader>v")
-- del("n", "<leader>la")
del("n", "<A-v>")
del("n", "<A-h>")
del("n", "<A-i>")

-- NvimTree
del("n", "<leader>n")
del("n", "<leader>rn")
-- Use leader+e instead
del("n", "<C-n>")
del("i", "<C-b>")
del("n", "<C-c>")

map("n", "Q", "<Nop>")
-- General
map("n", "<leader>rn", [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("n", "<leader>nc", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "<C-a>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map({ "n", "v" }, "x", [["_x]], { desc = "Delete void register" })
map("x", "p", [["_dP]], { desc = "Paste void register" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Visual move up", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Visual move down", silent = true })
-- Float diagnostic
map("n", "<leader>f", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Float diagnostic" })

-- Nvimtree toggle
map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "NvimTree Explorer toggle" })

map("n", "<leader>nt", function()
  require("nvchad.themes").open()
end, { desc = "Theme Switcher" })

-- Telescope Undo
map("n", "<leader>u", "<cmd> Telescope undo <cr>", { desc = "Telescope undo" })

--Gitsign
map("n", "<leader>gb", "<cmd> Git blame <cr>", { desc = "Git blame" })
map("n", "<leader>gf", "<cmd> Git reformat <cr>", { desc = "Git reformat (Vewd)" })

-- yank line without leading space or newline
map("n", "<leader>y", "[[^y$]]", { desc = "Yank no newline" })

-- Hop
map("n", "<leader>h", "<cmd> HopWord <cr>", { desc = "Hop Word" })
map({ "n", "o" }, "<A-h>", function()
  require("tsht").nodes()
end, { desc = "TreeHopper Visual Selection" })

map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format" })

map({ "n", "v" }, "<leader>la", function()
  require("actions-preview").code_actions()
end, { desc = "Lsp code action" })
-- Lazygit: You must have external tool "lazygit" installed
-- Install and uncomment to add keymaps
-- map("n", "<leader>gg", function()
--   require("utils.lazygit").lazygit_toggle()
-- end, { desc = "Toggle Lazygit" })
