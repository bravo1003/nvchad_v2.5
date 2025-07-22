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
del("v", "<leader>fm")
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
del("n", "<A-v>")
del("n", "<A-h>")
del("n", "<A-i>")

-- NvimTree
del("n", "<leader>n")
del("n", "<leader>rn")
del("n", "<C-c>")
del("n", "<C-n>")
del("i", "<C-b>")

map("n", "Q", "<Nop>")
-- General
map("n", "<leader>rn", [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("v", "<leader>rn", [[:s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("n", "<leader>nc", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

map("i", "<C-a>", "<ESC>^i", { desc = "Beginning_of_line" })
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

-- Telescope Undo
map("n", "<leader>u", function()
  Snacks.picker.undo()
end, { desc = "Snacks undo" })

-- tab close
map("n", "<leader>X", "<cmd> tabc <cr>", { desc = "tab close" })

--Gitsign
map("n", "<leader>gb", "<cmd> Gitsigns blame <cr>", { desc = "Git blame" })
map("n", "<leader>gf", "<cmd> Git cl format <cr>", { desc = "Git format (Xperi)" })

map("n", "<leader>nt", function()
  require("nvchad.themes").open()
end, { desc = "Theme Switcher" })
-- File browser
map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "NvimTree Explorer toggle" })

-- Copy line without newline
map("n", "<leader>y", [[^y$]], { desc = "Yank no newline" })

-- Go to context
map("n", "<leader>cc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Go to context" })
-- Hop
map("n", "<leader>h", "<cmd> HopWord <cr>", { desc = "Hop Word" })
map({ "n", "o" }, "<A-h>", function()
  require("tsht").nodes()
end, { desc = "TreeHopper Visual Selection" })

--Lsp
map({ "n", "v" }, "<leader>lf", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "Format" })
